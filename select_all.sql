USE ocplds_database;

-- ============================================================
-- 15 SELECT queries for the OCPLDS Fortnite Custom Maps DB
-- ============================================================


-- Full run report with player, map, section, and week.
SELECT
    r.RunID,
    p.Username,
    m.MapName,
    ms.SectionName,
    ms.DifficultyLevel,
    r.CompletionTime,
    r.SourcePlatform,
    r.SubmissionDate,
    sw.WindowID,
    DATE(sw.StartDate) AS WeekStart,
    DATE(sw.EndDate) AS WeekEnd
FROM Runs r
JOIN Players p ON r.PlayerID = p.PlayerID
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
JOIN Submission_Windows sw ON r.WindowID = sw.WindowID
ORDER BY sw.WindowID, m.MapName, ms.SectionName, TIME_TO_SEC(r.CompletionTime);


-- Player performance summary.
SELECT
    p.Username,
    COUNT(r.RunID) AS TotalRuns,
    COUNT(DISTINCT m.MapID) AS MapsPlayed,
    TIME_FORMAT(SEC_TO_TIME(MIN(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS FastestTime,
    TIME_FORMAT(SEC_TO_TIME(MAX(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS SlowestTime,
    TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS AverageTime
FROM Players p
JOIN Runs r ON p.PlayerID = r.PlayerID
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
GROUP BY p.PlayerID, p.Username
ORDER BY TotalRuns DESC, p.Username;


-- Fastest run for each map section.
SELECT
    m.MapName,
    ms.SectionName,
    ms.DifficultyLevel,
    p.Username,
    r.CompletionTime AS BestTime,
    r.RunID,
    DATE(sw.StartDate) AS WeekStart
FROM Runs r
JOIN Players p ON r.PlayerID = p.PlayerID
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
JOIN Submission_Windows sw ON r.WindowID = sw.WindowID
JOIN (
    SELECT
        SectionID,
        MIN(TIME_TO_SEC(CompletionTime)) AS BestSeconds
    FROM Runs
    GROUP BY SectionID
) best
    ON r.SectionID = best.SectionID
   AND TIME_TO_SEC(r.CompletionTime) = best.BestSeconds
ORDER BY m.MapName, ms.SectionName;


-- Current leaderboard with player names and map names.
SELECT
    lb.LeaderboardID,
    sw.WindowID,
    DATE(sw.StartDate) AS WeekStart,
    m.MapName,
    ms.SectionName,
    lb.PlayerRank,
    p.Username,
    lb.BestTime
FROM Leaderboard lb
JOIN Players p ON lb.PlayerID = p.PlayerID
JOIN Map_Sections ms ON lb.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
JOIN Submission_Windows sw ON lb.WindowID = sw.WindowID
ORDER BY sw.WindowID, m.MapName, ms.SectionName, lb.PlayerRank;


-- Platform performance summary.
SELECT
    r.SourcePlatform,
    COUNT(r.RunID) AS TotalRuns,
    COUNT(DISTINCT r.PlayerID) AS DistinctPlayers,
    COUNT(DISTINCT m.MapID) AS DistinctMaps,
    TIME_FORMAT(SEC_TO_TIME(MIN(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS FastestTime,
    TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS AverageTime,
    SUM(CASE WHEN r.IsVerified = 0 THEN 1 ELSE 0 END) AS PendingVerification
FROM Runs r
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
GROUP BY r.SourcePlatform
ORDER BY TotalRuns DESC;


-- Map popularity and performance summary.
SELECT
    m.MapName,
    COUNT(DISTINCT ms.SectionID) AS SectionsWithRuns,
    COUNT(r.RunID) AS TotalRuns,
    COUNT(DISTINCT r.PlayerID) AS DistinctPlayers,
    TIME_FORMAT(SEC_TO_TIME(MIN(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS FastestTime,
    TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS AverageTime
FROM Maps m
JOIN Map_Sections ms ON m.MapID = ms.MapID
JOIN Runs r ON ms.SectionID = r.SectionID
GROUP BY m.MapID, m.MapName
ORDER BY TotalRuns DESC, m.MapName;


-- Weekly submission summary.
SELECT
    sw.WindowID,
    DATE(sw.StartDate) AS WeekStart,
    DATE(sw.EndDate) AS WeekEnd,
    COUNT(r.RunID) AS TotalRuns,
    COUNT(DISTINCT r.PlayerID) AS DistinctPlayers,
    COUNT(DISTINCT m.MapID) AS DistinctMaps,
    TIME_FORMAT(SEC_TO_TIME(MIN(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS FastestTime,
    TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(r.CompletionTime))), '%H:%i:%s') AS AverageTime
FROM Submission_Windows sw
LEFT JOIN Runs r ON sw.WindowID = r.WindowID
LEFT JOIN Map_Sections ms ON r.SectionID = ms.SectionID
LEFT JOIN Maps m ON ms.MapID = m.MapID
GROUP BY sw.WindowID, sw.StartDate, sw.EndDate
ORDER BY sw.StartDate;


-- Players who submitted runs on more than one map.
SELECT
    p.Username,
    COUNT(r.RunID) AS TotalRuns,
    COUNT(DISTINCT m.MapID) AS MapsPlayed,
    GROUP_CONCAT(DISTINCT m.MapName ORDER BY m.MapName SEPARATOR ', ') AS Maps
FROM Players p
JOIN Runs r ON p.PlayerID = r.PlayerID
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
GROUP BY p.PlayerID, p.Username
HAVING COUNT(DISTINCT m.MapID) > 1
ORDER BY MapsPlayed DESC, TotalRuns DESC;


-- Source links connected to multiple run rows.
SELECT
    r.SourcePlatform,
    r.SourceURL,
    COUNT(r.RunID) AS RunRows,
    GROUP_CONCAT(DISTINCT p.Username ORDER BY p.Username SEPARATOR ', ') AS Players,
    GROUP_CONCAT(DISTINCT m.MapName ORDER BY m.MapName SEPARATOR ', ') AS Maps,
    GROUP_CONCAT(ms.SectionName ORDER BY ms.SectionID SEPARATOR ', ') AS Sections
FROM Runs r
JOIN Players p ON r.PlayerID = p.PlayerID
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
GROUP BY r.SourcePlatform, r.SourceURL
HAVING COUNT(r.RunID) > 1
ORDER BY RunRows DESC;


-- Verification status summary.
SELECT
    r.SourcePlatform,
    r.IsVerified,
    r.ImageClear,
    COUNT(r.RunID) AS RunCount,
    MIN(r.SubmissionDate) AS EarliestSubmission,
    MAX(r.SubmissionDate) AS LatestSubmission
FROM Runs r
GROUP BY r.SourcePlatform, r.IsVerified, r.ImageClear
ORDER BY r.SourcePlatform, r.IsVerified, r.ImageClear;


-- Run time compared to section average.
SELECT
    p.Username,
    m.MapName,
    ms.SectionName,
    r.CompletionTime,
    TIME_FORMAT(SEC_TO_TIME(avg_stats.AvgSeconds), '%H:%i:%s') AS SectionAverage,
    ROUND(TIME_TO_SEC(r.CompletionTime) - avg_stats.AvgSeconds) AS DifferenceSeconds,
    CONCAT(
        CASE
            WHEN TIME_TO_SEC(r.CompletionTime) - avg_stats.AvgSeconds >= 0 THEN '+'
            ELSE '-'
        END,
        TIME_FORMAT(
            SEC_TO_TIME(ABS(ROUND(TIME_TO_SEC(r.CompletionTime) - avg_stats.AvgSeconds))),
            '%H:%i:%s'
        )
    ) AS DifferenceFromAverage
FROM Runs r
JOIN Players p ON r.PlayerID = p.PlayerID
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
JOIN (
    SELECT
        SectionID,
        AVG(TIME_TO_SEC(CompletionTime)) AS AvgSeconds
    FROM Runs
    GROUP BY SectionID
) avg_stats ON r.SectionID = avg_stats.SectionID
ORDER BY m.MapName, ms.SectionName, TIME_TO_SEC(r.CompletionTime);


-- First-place leaderboard count per player.
SELECT
    p.Username,
    COUNT(lb.LeaderboardID) AS FirstPlaceFinishes,
    COUNT(DISTINCT m.MapID) AS DistinctMapsWon,
    TIME_FORMAT(SEC_TO_TIME(MIN(TIME_TO_SEC(lb.BestTime))), '%H:%i:%s') AS FastestWinningTime,
    TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(lb.BestTime))), '%H:%i:%s') AS AverageWinningTime
FROM Leaderboard lb
JOIN Players p ON lb.PlayerID = p.PlayerID
JOIN Map_Sections ms ON lb.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
WHERE lb.PlayerRank = 1
GROUP BY p.PlayerID, p.Username
ORDER BY FirstPlaceFinishes DESC, p.Username;


-- Runs faster than the average for their difficulty level.
SELECT
    p.Username,
    m.MapName,
    ms.SectionName,
    ms.DifficultyLevel,
    r.CompletionTime,
    TIME_FORMAT(SEC_TO_TIME(diff_avg.AvgDifficultySeconds), '%H:%i:%s') AS DifficultyAverage,
    TIME_FORMAT(
        SEC_TO_TIME(diff_avg.AvgDifficultySeconds - TIME_TO_SEC(r.CompletionTime)),
        '%H:%i:%s'
    ) AS FasterBy
FROM Runs r
JOIN Players p ON r.PlayerID = p.PlayerID
JOIN Map_Sections ms ON r.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
JOIN (
    SELECT
        ms2.DifficultyLevel,
        AVG(TIME_TO_SEC(r2.CompletionTime)) AS AvgDifficultySeconds
    FROM Runs r2
    JOIN Map_Sections ms2 ON r2.SectionID = ms2.SectionID
    GROUP BY ms2.DifficultyLevel
) diff_avg ON ms.DifficultyLevel = diff_avg.DifficultyLevel
WHERE TIME_TO_SEC(r.CompletionTime) < diff_avg.AvgDifficultySeconds
ORDER BY ms.DifficultyLevel,
         diff_avg.AvgDifficultySeconds - TIME_TO_SEC(r.CompletionTime) DESC;


-- Latest leaderboard result for each section.
SELECT
    m.MapName,
    ms.SectionName,
    DATE(sw.StartDate) AS LatestWeekStart,
    lb.PlayerRank,
    p.Username,
    lb.BestTime
FROM Leaderboard lb
JOIN Players p ON lb.PlayerID = p.PlayerID
JOIN Map_Sections ms ON lb.SectionID = ms.SectionID
JOIN Maps m ON ms.MapID = m.MapID
JOIN Submission_Windows sw ON lb.WindowID = sw.WindowID
JOIN (
    SELECT
        SectionID,
        MAX(WindowID) AS LatestWindowID
    FROM Leaderboard
    GROUP BY SectionID
) latest
    ON lb.SectionID = latest.SectionID
   AND lb.WindowID = latest.LatestWindowID
ORDER BY m.MapName, ms.SectionName, lb.PlayerRank;


-- Possible duplicate player accounts based on similar usernames.
SELECT
    normalized.NormalizedUsername,
    COUNT(*) AS MatchingAccounts,
    GROUP_CONCAT(normalized.PlayerID ORDER BY normalized.PlayerID SEPARATOR ', ') AS PlayerIDs,
    GROUP_CONCAT(normalized.Username ORDER BY normalized.PlayerID SEPARATOR ', ') AS Usernames
FROM (
    SELECT
        PlayerID,
        Username,
        LOWER(REPLACE(REPLACE(Username, '.', ''), '-', '')) AS NormalizedUsername
    FROM Players
) normalized
GROUP BY normalized.NormalizedUsername
HAVING COUNT(*) > 1;


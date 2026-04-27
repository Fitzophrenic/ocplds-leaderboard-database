USE ocplds_database;

-- Players registered in the OCPLDS leaderboard.
insert into Players (PlayerID, Username, DiscordID, Platform) values
(1, 'napezz', NULL, 'Discord'),
(2, 'K-O_l4n', NULL, 'Discord'),
(3, 'Purple_Disappointment', NULL, 'Discord'),
(4, 'dan davies', NULL, 'Discord'),
(5, 'Chaos_yin', NULL, 'Discord'),
(6, 'Skovlit', NULL, 'Twitter/X'),
(7, 'WOLFwithaSNIP3R', NULL, 'Twitter/X'),
(8, 'K.O_l4n', NULL, 'Discord'),
(9, 'josiegreig', NULL, 'Twitter/X'),
(10, 'MarcoLeon98', NULL, 'Twitter/X');

-- Fortnite parkour maps available for timed runs.
insert into Maps (MapID, MapName, MapCode) values
(1, 'Omega Parkour 500+', 'OMEGA500'),
(2, 'Default Parkour 425+', 'DFLT425'),
(3, 'TMNT Parkour', 'TMNT001'),
(4, 'Default Parkour', 'DFLT001'),
(5, 'Omega Parkour', 'OMEGA001'),
(6, 'Ultimate Parkour', 'ULTM001'),
(7, 'Default Obby Parkour 500+', 'DOBY500');

-- Map sections that players can submit runs for.
insert into Map_Sections (SectionID, MapID, SectionName, DifficultyLevel) values
-- Omega Parkour 500+ sections
(1, 1, 'Easy', 'Easy'),
(2, 1, 'Medium', 'Medium'),
(3, 1, 'Hard', 'Hard'),
-- Default Parkour 425+ sections
(4, 2, 'Main', 'Medium'),
-- TMNT Parkour sections
(5, 3, 'Main', 'Medium'),
-- Default Parkour sections
(6, 4, 'Bonus', 'Easy'),
-- Omega Parkour sections
(7, 5, 'Easy', 'Easy'),
(8, 5, 'Medium', 'Medium'),
(9, 5, 'Hard', 'Hard'),
-- Ultimate Parkour sections
(10, 6, 'Main', 'Hard'),
-- Default Obby Parkour 500+ sections
(11, 7, 'Main', 'Medium'),
(12, 7, 'Bonus', 'Easy');

-- Submission windows used to group leaderboard runs.
insert into Submission_Windows (WindowID, StartDate, EndDate, IsSeasonReset, ResetAppliedDate) values
(1, '2026-04-06 00:00:00', '2026-04-12 23:59:59', 0, NULL),
(2, '2026-04-13 00:00:00', '2026-04-19 23:59:59', 0, NULL),
(3, '2026-04-20 00:00:00', '2026-04-26 23:59:59', 0, NULL);

-- Player run submissions with proof links and verification flags.
-- === Week of 4/6/26 (WindowID 1) ===
insert into Runs (RunID, PlayerID, SectionID, WindowID, CompletionTime, ScreenshotURL, SourcePlatform, SourceURL, SubmissionDate, EntryMethod, IsVerified, ImageClear) values
-- napezz – Omega Parkour 500+ (Easy 23:42, Medium 06:34, Hard 14:00)
(1,  1, 1, 1, '00:23:42', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1488789995421564940', '2026-04-06 00:00:00', 'manual', 0, 0),
(2,  1, 2, 1, '00:06:34', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1488789995421564940', '2026-04-06 00:00:00', 'manual', 0, 0),
(3,  1, 3, 1, '00:14:00', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1488789995421564940', '2026-04-06 00:00:00', 'manual', 0, 0),
-- K-O_l4n – Default Parkour 425+ (Main 16:51)
(4,  2, 4, 1, '00:16:51', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1489387437095653406', '2026-04-06 00:00:00', 'manual', 0, 0),
-- K-O_l4n – TMNT Parkour (Main 10:22)
(5,  2, 5, 1, '00:10:22', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1489387547288277215', '2026-04-06 00:00:00', 'manual', 0, 0),
-- Purple_Disappointment – Default Parkour (Bonus 5:56)
(6,  3, 6, 1, '00:05:56', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1489473588112265326', '2026-04-06 00:00:00', 'manual', 0, 0),
-- dan davies – Omega Parkour (Easy 22:38, Medium 06:26, Hard 11:38)
(7,  4, 7, 1, '00:22:38', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1489615050690920650', '2026-04-06 00:00:00', 'manual', 0, 0),
(8,  4, 8, 1, '00:06:26', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1489615050690920650', '2026-04-06 00:00:00', 'manual', 0, 0),
(9,  4, 9, 1, '00:11:38', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1489615050690920650', '2026-04-06 00:00:00', 'manual', 0, 0),
-- Chaos_yin – Omega Parkour (Easy 11:29, Medium 04:11, Hard 05:17)
(10, 5, 7, 1, '00:11:29', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1490651044882026616', '2026-04-06 00:00:00', 'manual', 0, 0),
(11, 5, 8, 1, '00:04:11', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1490651044882026616', '2026-04-06 00:00:00', 'manual', 0, 0),
(12, 5, 9, 1, '00:05:17', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1490651044882026616', '2026-04-06 00:00:00', 'manual', 0, 0),
-- Skovlit – Default Parkour 425+ (Main 22:22)
(13, 6, 4, 1, '00:22:22', NULL, 'Twitter/X', 'https://x.com/skovlit/status/2039468470123839784?s=20', '2026-04-06 00:00:00', 'manual', 0, 0);

-- === Week of 4/13/26 (WindowID 2) ===
insert into Runs (RunID, PlayerID, SectionID, WindowID, CompletionTime, ScreenshotURL, SourcePlatform, SourceURL, SubmissionDate, EntryMethod, IsVerified, ImageClear) values
-- WOLFwithaSNIP3R – Omega Parkour 500+ (Medium 12:24)
(14, 7, 2, 2, '00:12:24', NULL, 'Twitter/X', 'https://x.com/home', '2026-04-13 00:00:00', 'manual', 0, 0),
-- Chaos_yin – Omega Parkour 500+ (Hard 04:14)
(15, 5, 3, 2, '00:04:14', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1493245677332070583', '2026-04-13 00:00:00', 'manual', 0, 0);

-- === Week of 4/20/26 (WindowID 3) ===
insert into Runs (RunID, PlayerID, SectionID, WindowID, CompletionTime, ScreenshotURL, SourcePlatform, SourceURL, SubmissionDate, EntryMethod, IsVerified, ImageClear) values
-- K.O_l4n – Omega Parkour 500+ (Easy 17:25)
(16, 8, 1, 3, '00:17:25', NULL, 'Discord', 'https://discord.com/channels/595505630958190593/1172700872833237033/1495029256303149227', '2026-04-20 00:00:00', 'manual', 0, 0),
-- josiegreig – Ultimate Parkour (Main 32:46)
(17, 9, 10, 3, '00:32:46', NULL, 'Twitter/X', 'https://x.com/home', '2026-04-20 00:00:00', 'manual', 0, 0),
-- MarcoLeon98 – Default Obby Parkour 500+ (Main 43:18, Bonus 3:16)
(18, 10, 11, 3, '00:43:18', NULL, 'Twitter/X', 'https://x.com/home', '2026-04-20 00:00:00', 'manual', 0, 0),
(19, 10, 12, 3, '00:03:16', NULL, 'Twitter/X', 'https://x.com/home', '2026-04-20 00:00:00', 'manual', 0, 0);

-- Current top-three leaderboard placements for selected sections.
-- Omega Parkour 500+ Easy (Window 1): napezz only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(1, 1, 1, 1, 1, 1, '00:23:42');

-- Omega Parkour 500+ Medium (Window 1): napezz only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(2, 2, 1, 2, 1, 1, '00:06:34');

-- Omega Parkour 500+ Hard (Window 1): napezz only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(3, 3, 1, 3, 1, 1, '00:14:00');

-- Default Parkour 425+ Main (Window 1): K-O_l4n #1, Skovlit #2
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(4, 4, 1, 4, 2, 1, '00:16:51'),
(5, 4, 1, 13, 6, 2, '00:22:22');

-- TMNT Parkour Main (Window 1): K-O_l4n only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(6, 5, 1, 5, 2, 1, '00:10:22');

-- Default Parkour Bonus (Window 1): Purple_Disappointment only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(7, 6, 1, 6, 3, 1, '00:05:56');

-- Omega Parkour Easy (Window 1): Chaos_yin #1, dan davies #2
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(8, 7, 1, 10, 5, 1, '00:11:29'),
(9, 7, 1, 7, 4, 2, '00:22:38');

-- Omega Parkour Medium (Window 1): Chaos_yin #1, dan davies #2
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(10, 8, 1, 11, 5, 1, '00:04:11'),
(11, 8, 1, 8, 4, 2, '00:06:26');

-- Omega Parkour Hard (Window 1): Chaos_yin #1, dan davies #2
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(12, 9, 1, 12, 5, 1, '00:05:17'),
(13, 9, 1, 9, 4, 2, '00:11:38');

-- Omega Parkour 500+ Medium (Window 2): WOLFwithaSNIP3R only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(14, 2, 2, 14, 7, 1, '00:12:24');

-- Omega Parkour 500+ Hard (Window 2): Chaos_yin only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(15, 3, 2, 15, 5, 1, '00:04:14');

-- Omega Parkour 500+ Easy (Window 3): K.O_l4n only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(16, 1, 3, 16, 8, 1, '00:17:25');

-- Ultimate Parkour Main (Window 3): josiegreig only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(17, 10, 3, 17, 9, 1, '00:32:46');

-- Default Obby Parkour 500+ Main (Window 3): MarcoLeon98 only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(18, 11, 3, 18, 10, 1, '00:43:18');

-- Default Obby Parkour 500+ Bonus (Window 3): MarcoLeon98 only
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(19, 12, 3, 19, 10, 1, '00:03:16');

-- Moderator verification records for accepted leaderboard runs.
-- (No runs verified yet — all submissions pending review.)

USE ocplds_database;

-- Players registered in the OCPLDS leaderboard.
insert into Players (PlayerID, Username, DiscordID, Platform) values
(1, 'StormSprint', 'stormsprint#1042', 'PC'),
(2, 'CrankRunner', 'crankrunner#2218', 'PlayStation'),
(3, 'EditDash', 'editdash#7741', 'Xbox'),
(4, 'ZoneClimber', 'zoneclimber#5390', 'Switch'),
(5, 'RampRush', 'ramprush#8863', 'PC');

-- Fortnite parkour maps available for timed runs.
insert into Maps (MapID, MapName, MapCode) values
(1, 'Skyline Sprint Parkour', 'SKY4821'),
(2, 'Tilted Tower Trials', 'TTT9104'),
(3, 'Neon Lava Climb', 'NLC3377');

-- Map sections that players can submit runs for.
insert into Map_Sections (SectionID, MapID, SectionName, DifficultyLevel) values
(1, 1, 'Main', 'Easy'),
(2, 1, 'Bonus', 'Medium'),
(3, 2, 'Main', 'Medium'),
(4, 2, 'Hard', 'Hard'),
(5, 3, 'Main', 'Hard'),
(6, 3, 'Easy', 'Easy');

-- Submission windows used to group leaderboard runs.
insert into Submission_Windows (WindowID, StartDate, EndDate, IsSeasonReset, ResetAppliedDate) values
(1, '2026-04-01 00:00:00', '2026-04-15 23:59:59', 0, NULL),
(2, '2026-04-16 00:00:00', '2026-04-30 23:59:59', 1, '2026-04-16 00:00:00');

-- Player run submissions with proof links and verification flags.
insert into Runs (RunID, PlayerID, SectionID, WindowID, CompletionTime, ScreenshotURL, SourcePlatform, SourceURL, SubmissionDate, EntryMethod, IsVerified, ImageClear) values
(1, 1, 1, 1, '00:01:12', 'https://img.ocplds/r001.png', 'Discord', 'https://discord.gg/r001', '2026-04-02 14:10:00', 'manual', 1, 1),
(2, 2, 1, 1, '00:01:15', 'https://img.ocplds/r002.png', 'Discord', 'https://discord.gg/r002', '2026-04-03 16:22:00', 'manual', 1, 1),
(3, 3, 1, 1, '00:01:21', 'https://img.ocplds/r003.png', 'YouTube', 'https://youtu.be/r003', '2026-04-04 18:45:00', 'auto', 1, 1),
(4, 4, 2, 1, '00:02:05', 'https://img.ocplds/r004.png', 'Discord', 'https://discord.gg/r004', '2026-04-06 12:30:00', 'manual', 0, 1),
(5, 5, 2, 1, '00:02:12', 'https://img.ocplds/r005.png', 'TikTok', 'https://tiktok.com/r005', '2026-04-07 21:05:00', 'manual', 0, 0),
(6, 1, 3, 2, '00:01:44', 'https://img.ocplds/r006.png', 'YouTube', 'https://youtu.be/r006', '2026-04-17 13:20:00', 'auto', 1, 1),
(7, 2, 3, 2, '00:01:39', 'https://img.ocplds/r007.png', 'Discord', 'https://discord.gg/r007', '2026-04-18 09:15:00', 'manual', 1, 1),
(8, 4, 3, 2, '00:01:47', 'https://img.ocplds/r008.png', 'YouTube', 'https://youtu.be/r008', '2026-04-19 19:40:00', 'auto', 1, 1),
(9, 5, 5, 2, '00:03:20', 'https://img.ocplds/r009.png', 'Discord', 'https://discord.gg/r009', '2026-04-21 22:10:00', 'manual', 0, 1),
(10, 3, 6, 2, '00:00:58', 'https://img.ocplds/r010.png', 'TikTok', 'https://tiktok.com/r010', '2026-04-23 11:55:00', 'manual', 0, 1);

-- Current top-three leaderboard placements for selected sections.
insert into Leaderboard (LeaderboardID, SectionID, WindowID, RunID, PlayerID, PlayerRank, BestTime) values
(1, 1, 1, 1, 1, 1, '00:01:12'),
(2, 1, 1, 2, 2, 2, '00:01:15'),
(3, 1, 1, 3, 3, 3, '00:01:21'),
(4, 3, 2, 7, 2, 1, '00:01:39'),
(5, 3, 2, 6, 1, 2, '00:01:44'),
(6, 3, 2, 8, 4, 3, '00:01:47');

-- Moderator verification records for accepted leaderboard runs.
insert into Verifications (VerificationID, RunID, VerifiedBy, VerifiedDate, RejectionNotes, HasNewTimes) values
(1, 1, 'ModNova', '2026-04-02 15:00:00', NULL, 1),
(2, 2, 'ModNova', '2026-04-03 17:05:00', NULL, 1),
(3, 3, 'BuilderByte', '2026-04-04 19:15:00', NULL, 1),
(4, 6, 'BuilderByte', '2026-04-17 14:10:00', NULL, 1),
(5, 7, 'ZoneJudge', '2026-04-18 10:00:00', NULL, 1),
(6, 8, 'ZoneJudge', '2026-04-19 20:25:00', NULL, 1);

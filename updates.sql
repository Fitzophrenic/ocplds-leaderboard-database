USE ocplds_database;

-- UPDATE 1
-- Verify all runs submitted in Week 1 (Window 1) after moderator review.
-- A moderator has reviewed and approved all run submissions from the first
-- submission window. Update IsVerified to 1 for every run belonging to Window 1.

UPDATE Runs
SET IsVerified = 1
WHERE WindowID = 1;


-- UPDATE 2
-- Correct a player's completion time after a screenshot re-review.
-- After re-examining the screenshot proof, the moderator discovered that
-- napezz's Hard run on Omega Parkour 500+ (RunID 3) was misread. The correct
-- time is 00:13:45, not 00:14:00. Update the run time in both the Runs table
-- and the Leaderboard table.

UPDATE Runs
SET CompletionTime = '00:13:45'
WHERE RunID = 3;

UPDATE Leaderboard
SET BestTime = '00:13:45'
WHERE RunID = 3;


-- UPDATE 3
-- Link a player's Discord ID after they provide it.
-- The player Chaos_yin (PlayerID 5) has provided their Discord ID.
-- Update their record to store the Discord ID "chaos_yin#4521".

UPDATE Players
SET DiscordID = 'chaos_yin#4521'
WHERE PlayerID = 5;


-- UPDATE 4
-- Flag runs with unclear image proof as needing re-submission.
-- The moderator has determined that the Twitter/X submissions from Window 3
-- (RunIDs 17, 18, and 19) do not have clear enough screenshot proof.
-- Set ImageClear to 0 and mark them as unverified (IsVerified = 0)
-- pending better evidence.

UPDATE Runs
SET ImageClear = 0,
    IsVerified = 0
WHERE SourcePlatform = 'Twitter/X'
  AND WindowID = 3;


-- UPDATE 5
-- Merge duplicate player accounts by reassigning runs to the canonical account.
-- K-O_l4n (PlayerID 2) and K.O_l4n (PlayerID 8) have been identified as the
-- same person with two slightly different usernames. All runs belonging to
-- PlayerID 8 are reassigned to PlayerID 2 (the original/canonical account),
-- and the leaderboard entry is updated to match.

UPDATE Runs
SET PlayerID = 2
WHERE PlayerID = 8;

UPDATE Leaderboard
SET PlayerID = 2
WHERE PlayerID = 8;

# ocplds-leaderboard-database
A leaderboard and data submission database system for Omega Creations Parkour, tracking player runs, scores, and rankings.

## Database Setup (MySQL)

Run the files in this order from a fresh MySQL session:

```bash
mysql -u root < setup.sql
mysql -u root ocplds_database < schema.sql
mysql -u root ocplds_database < sample_data.sql
mysql -u root ocplds_database < select_all.sql
```
Note if you want the output to be in table format use this command (assuming you ran first 3 commands above)

```bash
mysql -u root -t ocplds_database < select_all.sql
```

## Files
- `schema.sql` — table definitions, primary/foreign keys, and constraints
- `setup.sql` — creates the `ocplds_database` and selects it for use
- `sample_data.sql` — sample inserts for all 7 tables (Players, Maps, Map_Sections, Submission_Windows, Runs, Leaderboard, Verifications)
- `select_all.sql` — `SELECT *` from each table, used to capture screenshots for the report

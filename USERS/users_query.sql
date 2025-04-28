SELECT id,lead_user_id FROM public.users
ORDER BY id ASC LIMIT 10

SELECT * FROM public.users
LIMIT 10;

SELECT username, state, status
FROM public.users 
LIMIT 10;

SELECT state, COUNT(*) AS user_count
FROM public.users
GROUP BY state
LIMIT 10;

-- 2 states online and offline
---------------------------------------------
SELECT status, COUNT(*) AS total
FROM public.users
GROUP BY status;

-- there are 4 different status --> active, blocked, inactive, unverified
-------------------------------------------------------------------------------------
-- Q. How many users are in each state + status combination.
SELECT state, status, COUNT(*)
FROM public.users
GROUP BY state, status
ORDER BY state, status;
-- it groups by state and status 

-- Q. List users created per month.

SELECT TO_CHAR(created_at, 'YYYY-MM') AS created_month, COUNT(*) AS users_created
FROM public.users
GROUP BY created_month
ORDER BY created_month;
---------------------------------------------------------------------------------------

-- Q. find the earliest and latest users created
SELECT MIN(created_at) AS first_user, MAX(created_at) AS latest_user
FROM public.users;
--------------------------------------------------------------------------------

-- Q. List users who don't have a middle name

SELECT id, username, first_name, last_name
FROM public.users
WHERE middle_name IS NULL;

-- Q. List users grouped by time_zone
SELECT time_zone, COUNT(*) AS users_per_timezone
FROM public.users
GROUP BY time_zone
ORDER BY users_per_timezone DESC;
-------------------------------------------------------------------

-- Q. Group users by stage

SELECT stage, COUNT(*) AS users_in_stage
FROM public.users
GROUP BY stage
ORDER BY users_in_stage DESC;



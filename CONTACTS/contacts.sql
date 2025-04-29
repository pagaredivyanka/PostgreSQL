SELECT * FROM public.contacts
limit 100;

SELECT type, COUNT(*) AS total_contacts
FROM public.contacts
GROUP BY type;

-- 5. Group by category and platform

SELECT category, platform, COUNT(*) AS count
FROM public.contacts
GROUP BY category, platform
ORDER BY count DESC;

-- Q. Count contacts by country_code

SELECT country_code, COUNT(*) AS total
FROM public.contacts
GROUP BY country_code
ORDER BY total DESC;

-- 6. Verified vs unverified contacts

SELECT verified, COUNT(*) AS count
FROM public.contacts
GROUP BY verified;

-- 7. Group by status

SELECT status, COUNT(*) AS total
FROM public.contacts
GROUP BY status;

-- 
-- "status"	    "total"
-- "active"	    757710
-- "inactive"	3822

-- 8. Inactive contacts per stage
SELECT stage, COUNT(*) AS inactive_count
FROM public.contacts
WHERE status = 'inactive'
GROUP BY stage;

-- 9. Contacts with channel = 'email' grouped by platform

SELECT platform, COUNT(*) AS email_contacts
FROM public.contacts
WHERE channel = 'email'
GROUP BY platform;

-- 10. COunt contacts updated today

SELECT COUNT(*) AS updated_today
FROM public.contacts
WHERE updated_at::date = CURRENT_DATE;

-- 11. List latest updated contacts

SELECT id, type, value, updated_at
FROM public.contacts
ORDER BY updated_at DESC
LIMIT 10;

-- 12. Unique type + platform combinations

SELECT DISTINCT type, platform
FROM public.contacts;

-- 13. Group by type and filter (HAVING) for large groups

SELECT type, COUNT(*) AS total
FROM public.contacts
GROUP BY type
HAVING COUNT(*) > 100;

-- 14. Extract year-wise contacts

SELECT EXTRACT(YEAR FROM created_at) AS year, COUNT(*) AS total
FROM public.contacts
GROUP BY year
ORDER BY year;

-- 15. Most common eformat types

SELECT eformat, COUNT(*) AS usage_count
FROM public.contacts
GROUP BY eformat
ORDER BY usage_count DESC;

-- 16. find all unverified contacts

SELECT id, value, type
FROM public.contacts
WHERE verified = false
LIMIT 100;

-- 17. Get all distinct channels 

SELECT DISTINCT channel 
FROM public.contacts;

-- 18. Window function: Rank contacts by recent update

SELECT id, object_id, updated_at,
	RANK() OVER (ORDER BY updated_at DESC) AS updated_rank
FROM public.contacts;


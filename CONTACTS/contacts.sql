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

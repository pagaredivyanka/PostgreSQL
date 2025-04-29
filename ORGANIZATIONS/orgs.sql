-- 1. Preview the top records

SELECT * FROM public.organizations LIMIT 10;

-- 2. Total number of organizations

SELECT COUNT(*) AS total_organizations FROM public.organizations;

-- 3. Organizations grouped by country_id

SELECT country_id, COUNT(*) AS org_count
FROM public.organizations
GROUP BY country_id
ORDER BY org_count DESC;

-- 4. Unique values of account_type

SELECT DISTINCT account_type FROM public.organizations;
-- 5. Count by account_type

SELECT account_type, COUNT(*) AS total
FROM public.organizations
GROUP BY account_type
ORDER BY total DESC;
--  6. Active vs Inactive organizations

SELECT status, COUNT(*) AS total
FROM public.organizations
GROUP BY status;
 -- 7. Search for an organization by name

SELECT * 
FROM public.organizations
WHERE business_name ILIKE '%logistics%';
 -- 8. Organizations with logos

SELECT * 
FROM public.organizations
WHERE logo IS NOT NULL;
 -- 9. Organizations with a website

SELECT * 
FROM public.organizations
WHERE website IS NOT NULL AND website <> '';
-- 10. Most recently created organizations

SELECT *
FROM public.organizations
ORDER BY created_at DESC
LIMIT 10;
 -- 11. Organizations updated in the last 30 days

SELECT *
FROM public.organizations
WHERE updated_at >= NOW() - INTERVAL '30 days';
-- 12. Organizations missing registration or IEC number

SELECT *
FROM public.organizations
WHERE registration_number IS NULL OR iec_number IS NULL;
-- 13. Organizations with comments

SELECT id, business_name, comment
FROM public.organizations
WHERE comment IS NOT NULL;
-- 14. Organizations tagged with a specific tag

SELECT * 
FROM public.organizations
WHERE tags ILIKE '%exporter%';
 -- 15. Organizations with old_serial_id present

SELECT * 
FROM public.organizations
WHERE old_serial_id IS NOT NULL;
-- 16. Case-insensitive brand or trade name search

SELECT id, brand_name, trade_name 
FROM public.organizations
WHERE brand_name ILIKE '%global%' OR trade_name ILIKE '%global%';
--17. Find duplicates by business name

SELECT business_name, COUNT(*) 
FROM public.organizations
GROUP BY business_name
HAVING COUNT(*) > 1;

-- 18. Organizations with a lead organization

SELECT * 
FROM public.organizations
WHERE lead_organization_id IS NOT NULL;
 -- 19. Top channels used
SELECT channel, COUNT(*) AS total
FROM public.organizations
GROUP BY channel
ORDER BY total DESC;

-- 20. Monthly creation trend

SELECT TO_CHAR(created_at, 'YYYY-MM') AS month, COUNT(*) AS total
FROM public.organizations
GROUP BY month
ORDER BY month;
 -- 21. Sample Fuzzy Search using search_vector (if using PostgreSQL Full-Text Search)

SELECT * 
FROM public.organizations
WHERE search_vector @@ to_tsquery('export | shipping');
Make sure search_vector is configured and indexed properly if used for search.

-- Bonus: Suggested Join Example
-- If entity_mappings.mapped_entity_id or mapped_to_entity_id refers to organizations.id, you can try:

SELECT em.*, o.business_name
FROM public.entity_mappings em
JOIN public.organizations o ON em.mapped_entity_id = o.id;

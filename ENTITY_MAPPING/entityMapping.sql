SELECT * from public.entity_mappings LIMIT 10;

-- 2. Total count of mappings 

SELECT COUNT(*) AS total_mappings FROM public.entity_mappings;

-- 3. Distinct mapped_entity_type values

SELECT DISTINCT mapped_entity_type FROM public.entity_mappings;

-- 4. Group by mapped_entity_type and count

SELECT mapped_entity_type, COUNT(*) AS total
FROM public.entity_mappings
GROUP BY mapped_entity_type
ORDER BY total DESC;

-- 5. Cross-tab: Mapped entity vs mapped to entity

SELECT mapped_entity_type, mapped_to_entity_type, COUNT(*) AS relation_count
FROM public.entity_mappings
GROUP BY mapped_entity_type, mapped_to_entity_type
ORDER BY relation_count DESC;

-- 6. Mappings per stakeholder_type

SELECT stakeholder_type, COUNT(*) AS total
FROM public.entity_mappings
GROUP BY stakeholder_type;

-- 7. Top 5 most frequent cogo_entity_id

SELECT cogo_entity_id, COUNT(*) AS frequency
FROM public.entity_mappings 
GROUP BY cogo_entity_id
ORDER BY frequency DESC
LIMIT 5;

-- 8. Mappings with status = 'inactive'

SELECT * FROM public.entity_mappings
WHERE status = 'inactive';

-- 9. Yearly trend of mappings created

SELECT EXTRACT(YEAR FROM created_at) AS year, COUNT(*) AS total
FROM public.entity_mappings
GROUP BY year
ORDER BY year;

-- 10. Monthly mapping trend

SELECT TO_CHAR(created_at, 'YYYY-MM') AS month, COUNT(*) AS total
FROM public.entity_mappings
GROUP BY month
ORDER BY month;

-- 11. Mappings grouped by role_id

SELECT role_id, COUNT(*) AS total
FROM public.entity_mappings
GROUP BY role_id
ORDER BY total DESC;

-- 12. List mappings involving a specific entity ID

-- SELECT * 
-- FROM public.entity_mappings
-- WHERE mapped_entity_id = 'YOUR_ENTITY_ID';

-- 13. Mappings with non-null meta_data

SELECT * 
FROM public.entity_mappings
WHERE meta_data IS NOT NULL;

-- 14. Distinct conbinations of mapping types

SELECT DISTINCT mapped_entity_type, mapped_to_entity_type, mapped_to_sub_entity_type
FROM public.entity_mappings;

-- 15. Get the most recent mappings

SELECT * 
FROM public.entity_mappings
ORDER BY updated_at DESC
LIMIT 10;

-- 16. Find top sources of mappings

SELECT source, COUNT(*) AS source_count
FROM public.entity_mappings
GROUP BY source
ORDER BY source_count DESC;

-- 17. Find mappings with missing mapped_to_sub_entity_id

SELECT * 
FROM public.entity_mappings
WHERE mapped_to_sub_entity_id IS NULL;

-- 18. Role vs Stakeholder Type matrix

SELECT role_id, stakeholder_type, COUNT(*) AS total
FROM public.entity_mappings
GROUP BY role_id, stakeholder_type
ORDER BY total DESC;

-- 19. Window Function: Row Number by mapped_entity_type

SELECT id, mapped_entity_type, mapped_to_entity_type,
	ROW_NUMBER() OVER (PARTITION BY mapped_entity_type ORDER BY created_at DESC) AS rn
FROM public.entity_mappings;

-- 20. Find mappings not updated in the last 6 months

SELECT *
FROM public.entity_mappings
WHERE updated_at < CURRENT_DATE - INTERVAL '6 months';



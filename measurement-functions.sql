--What is the area of all parcels zoned for agriculture?
SELECT *, st_area(geom) as area_sqm
FROM spatial_sql_webinar.windsor_parcels
WHERE zoning LIKE 'A%';

--What is the total area of all parcels zoned for agriculture?
SELECT sum(st_area(geom)) as sum_area_sqm
FROM spatial_sql_webinar.windsor_parcels
WHERE zoning LIKE 'A%';

--Cast to numeric and limit the decimal places with the round() function.
SELECT round(sum(st_area(geom))::numeric,2) as sum_area_sqm
FROM spatial_sql_webinar.windsor_parcels
WHERE zoning LIKE 'A%';

--Let do the same with the first statement.
SELECT *, round(st_area(geom)::numeric,2) as area_sqm
FROM spatial_sql_webinar.windsor_parcels
WHERE zoning LIKE 'A%';

--How many segments are there for Richmond Street and what is the total, minimum, and maximum lengths of these segments?
SELECT sum(st_length(geom)) sum_length_m, 
	count(*) segments_count, 
	round(max(st_length(geom))::numeric,2) max_seg_length_m, 
	round(min(st_length(geom))::numeric,2) min_seg_length_m
FROM spatial_sql_webinar.windsor_street_centreline
WHERE stname ILIKE 'richmond%';

--What is the perimeter of all parcels zoned for agriculture? 
SELECT *, round(st_perimeter(geom)::numeric,2) permimeter_m
FROM spatial_sql_webinar.windsor_parcels
WHERE zoning LIKE 'A%'
ORDER BY st_perimeter(geom);


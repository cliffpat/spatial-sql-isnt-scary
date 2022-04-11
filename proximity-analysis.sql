--How far is each parcel from a community centre?
SELECT DISTINCT ON (a.id) 
	a.*, b.centre,
	st_distance(a.geom,b.geom) as distance_m
FROM spatial_sql_webinar.windsor_parcels AS a
LEFT JOIN spatial_sql_webinar.windsor_community_centres b
ON st_dwithin(a.geom,b.geom,10000)
ORDER BY a.id, distance_m;

--CREATE TABLE spatial_sql_webinar.windsor_parcels_with_community_centres AS
SELECT DISTINCT ON (a.id) 
	a.*, b.centre,
	st_distance(a.geom,b.geom) as distance_m
FROM spatial_sql_webinar.windsor_parcels AS a
LEFT JOIN spatial_sql_webinar.windsor_community_centres b
ON st_dwithin(a.geom,b.geom,10000)
ORDER BY a.id, distance_m;

--How many residential parcels are there within 500m of the Willistead Heritage Complex?
SELECT count(*) AS residential_parcels
FROM spatial_sql_webinar.windsor_parcels_with_community_centres
WHERE centre LIKE 'Willistead Heritage Complex' AND distance_m < 500 AND zoning LIKE 'RD%';

--Which community centre served the highest number of residential parcels within a 2km radius? 
SELECT centre, count(centre) AS residential_parcels
FROM spatial_sql_webinar.windsor_parcels_with_community_centres
WHERE zoning LIKE 'RD%' AND distance_m < 2000
GROUP BY centre
ORDER BY residential_parcels desc;


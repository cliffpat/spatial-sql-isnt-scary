--Show me a 500m buffer around the community centres.
SELECT id, st_buffer(geom,500) AS geom 
FROM spatial_sql_webinar.windsor_community_centres;

--Which parcels intersect with the community centres?
SELECT id, st_buffer(geom,500) AS geom 
FROM spatial_sql_webinar.windsor_community_centres;

--Which parcels intersect a 500m buffer around each community centre?
SELECT a.*
FROM spatial_sql_webinar.windsor_parcels a, spatial_sql_webinar.windsor_community_centres b
WHERE st_intersects(a.geom,st_buffer(b.geom,500));

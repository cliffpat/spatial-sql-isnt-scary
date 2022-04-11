--Join the community centres and the parcels if they intersect. 
SELECT a.*, b.roll_fix
FROM spatial_sql_webinar.windsor_community_centres AS a
LEFT JOIN spatial_sql_webinar.windsor_parcels AS b
ON st_intersects(a.geom, b.geom);


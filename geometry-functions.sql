--Transform geometries using the st_transform() function.
SELECT a.*
FROM spatial_sql_webinar.windsor_parcels a, spatial_sql_webinar.windsor_arenas b
WHERE st_intersects(a.geom,st_transform(b.geom,26917));

--Find the X and Y coordinates using the ST_X() and ST_Y() functions.
SELECT *, round(st_x(st_transform(geom,26917))::numeric,2) easting, 
round(st_y(st_transform(geom,26917))::numeric,2) northing,
round(st_x(geom)::numeric,6) long, 
round(st_y(geom)::numeric,6) lat
FROM spatial_sql_webinar.windsor_arenas;

--Get the centroid of a polygon.
SELECT id, st_centroid(geom) geom
FROM spatial_sql_webinar.windsor_parcels
WHERE id = 16257;

--Get the start and end points of a linestring.
SELECT st_startpoint(geom) as geom
FROM spatial_sql_webinar.demo_linestring
UNION
SELECT st_endpoint(geom) as geom
FROM spatial_sql_webinar.demo_linestring;


--Well-known text
SELECT centre, 
st_asText(geom) AS wkt, 
st_asewkt(geom) AS ewkt
FROM spatial_sql_webinar.windsor_community_centres;

--KML
SELECT centre, 
st_asKML(geom) AS kml
FROM spatial_sql_webinar.windsor_community_centres;

--GeoJSON
SELECT centre, 
st_asgeojson(geom) AS geojson
FROM spatial_sql_webinar.windsor_community_centres;

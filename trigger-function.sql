--Create the table
CREATE TABLE spatial_sql_webinar.proposed_park_areas ( 
	id serial primary key, 
	geom geometry(Polygon, 26917), 
	centre_northing numeric, 
	centre_easting numeric,
	centre_latitude numeric, 
	centre_longitude numeric,  
	centre_latlong_dms varchar, 
	area_sqm decimal,  
	street_address varchar,
	ward varchar,
	nearest_road_name varchar,
	distance_to_nearest_road_m numeric,
	nearest_hospital varchar,
	distance_to_nearest_hospital_m numeric,
	kml_output varchar,
	geojson_output varchar,
	date_created timestamp with time zone DEFAULT now(), 
	created_by character varying DEFAULT "current_user"(), 
	date_modified timestamp with time zone, 
	modified_by character varying
);

--Trigger Function
CREATE FUNCTION spatial_sql_webinar.tutorial_trigger_function() RETURNS trigger AS $$
  BEGIN  
  
  NEW.centre_northing = round(st_y(st_centroid(NEW.geom))::numeric,2);   
  NEW.centre_easting = round(st_x(st_centroid(NEW.geom))::numeric,2);  
  NEW.centre_latitude = round(st_y(st_centroid(st_transform(NEW.geom,4326)))::numeric,6);   
  NEW.centre_longitude = round(st_x(st_centroid(st_transform(NEW.geom,4326)))::numeric,6);  
  NEW.centre_latlong_dms = ST_AsLatLonText(st_centroid(st_transform(NEW.geom,4326)));  
  NEW.area_sqm = round(st_area(NEW.geom)::numeric,2);  
  NEW.street_address = (SELECT add_range  	
                        FROM spatial_sql_webinar.windsor_parcels  	
                        WHERE st_intersects(st_centroid(NEW.geom), geom));  
  NEW.ward = (SELECT ward  	
              FROM spatial_sql_webinar.windsor_wards  	
              WHERE st_intersects(st_centroid(NEW.geom), geom));  
  
  NEW.nearest_road_name = (SELECT stname 	
                           FROM spatial_sql_webinar.windsor_street_centreline a 	
                           ORDER BY a.geom <-> NEW.geom 	
                           LIMIT 1);  
  
  NEW.distance_to_nearest_road_m = (SELECT round(st_distance(a.geom,NEW.geom)::numeric,2) 	
                                    FROM spatial_sql_webinar.windsor_street_centreline a 	
                                    ORDER BY a.geom <-> NEW.geom 	
                                    LIMIT 1);	   
                                    
  NEW.nearest_hospital = (SELECT name 	
                           FROM spatial_sql_webinar.windsor_hospitals a 	
                           ORDER BY a.geom <-> NEW.geom 	
                           LIMIT 1);  
  
  NEW.distance_to_nearest_hospital_m = (SELECT round(st_distance(a.geom,NEW.geom)::numeric,2) 	
                                    FROM spatial_sql_webinar.windsor_hospitals a 	
                                    ORDER BY a.geom <-> NEW.geom 	
                                    LIMIT 1);	
 
 
 NEW.kml_output = st_askml(NEW.geom);  
 NEW.geojson_output = st_asgeojson(NEW.geom);    
 NEW.date_modified = now();  
 NEW.modified_by = "current_user"();    
 
 RETURN NEW; END;

 RETURN NEW;
END;

$$ language plpgsql;

--The Trigger
CREATE TRIGGER tutorial_trigger
 BEFORE INSERT OR UPDATE
 ON spatial_sql_webinar.proposed_park_areas
 FOR EACH ROW
 EXECUTE PROCEDURE spatial_sql_webinar.tutorial_trigger_function();

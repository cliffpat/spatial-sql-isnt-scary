--Select query
SELECT *
from spatial_sql_webinar.demo_table;

--Where clause
select *
from spatial_sql_webinar.demo_table
WHERE age > 40;

--Update statement
UPDATE spatial_sql_webinar.demo_table
	SET age = 50
	WHERE id = 1;

--INSERT statement
INSERT INTO spatial_sql_webinar.demo_table (name,age)
	VALUES ('Peter',47);

--Delete statement 
DELETE FROM spatial_sql_webinar.demo_table
	WHERE id = 5;

--Create Table
CREATE TABLE spatial_sql_webinar.demo_table2 (
	id serial primary key,
	name varchar(255),
	age integer
);



use moviesdb;


-- display all columns in the table
SELECT * FROM movies;

-- To select specific columns from a table
select movie_id, title, industry from movies;


-- Select all movies from bollywood
select * from movies
where industry = 'bollywood';

-- display all hollywood movies
select * from movies
where industry = 'hollywood';


-- count no.of bollywood movies
select count(*) from movies
where industry = 'bollywood';

# Gives the structure of the table
desc movies;


-- Display all the unique industries in the table
select distinct(industry) from movies;


-- select all thor movies
select * from movies
where title like "%thor%";


-- all movies that have no value in studio
select * from movies
where studio = "";

select * from movies
where studio is Null or studio = "";


-- select all records where the rating is greater than or equals 9
select * from movies
where imdb_rating >= 9;


-- select all records where the rating is between 6 & 8
select * from movies
where imdb_rating between 6 and 8;

select * from movies
where imdb_rating > 6 and imdb_rating < 8;


-- using "in" operator to display multiple "OR" conditions

-- instead of using this:
Select * from movies
where release_year = 2022 or release_year = 2019 or release_year = 2018;


select * from movies
where release_year in (2022, 2019);


-- getting null value records
select * from movies
where imdb_rating IS NULL;



-- Using Order by (to change the order of the output to ascending or descending)
select * from movies
where industry = "Bollywood"
order by imdb_rating desc;


-- Display only first 5 highest rating movies
select * from movies
where industry = "bollywood"
order by imdb_rating desc
limit 5;


-- To display the records from the 1st index -- offset usually starts with index 0
select * from movies
where industry = "bollywood"
order by imdb_rating desc
limit 10
offset 1;


-- Aggregation functions (min, max, avg, sum, count)

-- 1. Max(), get the max imdb_rating of all the movies, which are release in the year 2014
select * from movies
where release_year = 2014;


select max(imdb_rating) from movies
where release_year = 2014;


-- 2. Min()
select min(imdb_rating) from movies;


-- 3. avg() - check avg rating of marvel movies
select avg(imdb_rating) from movies
where studio like "%marvel%";

-- to round of the decimals
select round(avg(imdb_rating),2) as avg_rating from movies
where studio like "%marvel%";


-- 4. count()
select count(*) from movies;



-- Group by: Used to group rows that have same values into summary rows

-- printing num of movies in the studio
select studio, count(*)
from movies
group by studio;


-- Having clause: Used after group by. Used to filter results of group by based on results of agregate functions

-- print all years where more than 2 movies were released
select release_year, count(*) as movies_count
from movies
group by release_year
Having movies_count > 2;









-- Actors table

select * from actors;


-- To get the age of each actor - we need to get the current year and substract birth year from current year

-- Get current date
select curdate( );

-- extract current year from current date
select year(curdate());

-- Calculate current age and add it as a new column 
select *, year(curdate()) - birth_year as age from actors;








-- Financial table

select * from financials;


-- Find profit
select *, (revenue-budget) as profit
from financials;


-- Convert USD to INR, and create new col
select *, 
if(currency = "USD", revenue * 87, revenue) as revenue_INR
from financials;


-- Using CASE statement: CASE in SQL is used when we have multiple conditions, like if-else

-- convert all revenue into millions & create new col 
select *, 
CASE
when unit = "Billions" then revenue * 1000
when unit = "Thousands" then revenue/1000
when unit = "Millions" then revenue
END as revenue_Millions
from financials;




select * from movies;
select * from financials;

-- Joining tables

-- 1. Inner join:  Displays the intersection of records -- records present in both the tables will be displayed
select m.movie_id, title, revenue, budget, currency, unit
from movies m
join
financials f
on m.movie_id = f.movie_id;


-- 2. Left join: All the records in the left table and the intersection of records from both tables will be displayed

select  m.movie_id, title, revenue, budget, currency, unit
from movies m
Left join 
financials f
on m.movie_id = f.movie_id;


-- 3. Right join: All the records in the Right table and the intersection of records from both tables will be displayed

select  m.movie_id, title, revenue, budget, currency, unit
from movies m
Right join 
financials f
on m.movie_id = f.movie_id;


-- 4. To get all the records from both the tables, MYSQL doesn't support full outer join to join both tables, 
--  use UNION, when duplicates should be removed, otherwise use UNION ALL

select m.movie_id, title, revenue, budget, currency, unit
from movies m
left join 
financials f
on m.movie_id = f.movie_id

Union 

select m.movie_id, title, revenue, budget, currency, unit
from movies m
Right join 
financials f
on m.movie_id = f.movie_id;


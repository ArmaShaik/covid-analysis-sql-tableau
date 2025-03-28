CREATE DATABASE IF NOT EXISTS yelp;

use yelp;

# now create the business table 

CREATE TABLE business
(
    bid int,
    business_id varchar(100),
    name varchar(100),
    address varchar(150),
    city varchar(100),
    state varchar(100),
    postal_code varchar(50),
    latitude float,
    longitude float,
    stars float,
    review_count int,
    is_open int
);

SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
#upload the business table from the csv file. replace the path with the path in your machine where the file is located

LOAD DATA LOCAL INFILE 'C:/MSBA/Data Technology/yelp_academic_dataset_business.csv' INTO TABLE yelp.business
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(bid, business_id, name, address, city, state, postal_code, latitude, longitude, stars, review_count, is_open);

#create the user table 

CREATE TABLE user
(
    uid int,
    user_id varchar(100),
    name varchar(100),
    review_count int,
    yelping_since TIMESTAMP  DEFAULT CURRENT_TIMESTAMP NOT NULL, -- note difference from MySQL
    average_stars float,
    useful_votes int,
    funny_votes int,
    cool_votes int,
    fans int,
    compliment_hot int,
    compliment_more int,
    compliment_profile int,
    compliment_cute int,
    compliment_list int,
    compliment_note int,
    compliment_plain int,
    compliment_cool int,
    compliment_funny int,
    compliment_writer int,
    compliment_photos int
);

#upload the user table from the csv file. replace the path with the path in your machine where the file is located

LOAD DATA LOCAL INFILE 'C:/MSBA/Data Technology/yelp_academic_dataset_user.csv'
INTO TABLE yelp.user
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(uid,user_id,name,review_count,yelping_since,average_stars,useful_votes,funny_votes,cool_votes,fans,compliment_hot,compliment_more,
 compliment_profile,compliment_cute,compliment_list,compliment_note,compliment_plain,compliment_cool,compliment_funny,compliment_writer,
    compliment_photos);


# now repeat the same for review_notext

CREATE TABLE review_notext
(
    rid int,
    review_id varchar(100),
    business_id varchar(100),
    user_id varchar(100),
    stars int,
    date date,
    userful_votes int,
    funny_votes int,
    cool_votes int
);

LOAD DATA LOCAL INFILE 'C:/MSBA/Data Technology/yelp_academic_dataset_review_notext.csv'
INTO TABLE yelp.review_notext
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
(rid,review_id,business_id,user_id,stars,date,userful_votes,funny_votes,cool_votes);

# repeat the same for category table 

CREATE TABLE category
(
    cid int,
    business_id varchar(100),
    category_name varchar(100)
);


LOAD DATA LOCAL INFILE 'C:/MSBA/Data Technology/yelp_academic_dataset_category.csv'
INTO TABLE yelp.category
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cid, business_id, category_name);

/*This is optional. Only if you want to look at the review text, which was part of the original review table. 
This is not required for assignments or final exam */

-- TOP 50 restaurant data

CREATE TABLE Top_50_Restaurant_data
(
    fast_food_chains varchar(100),
    america_systemwide_sales_millions_usd int,
    avg_sales_per_unit_thousands_usd int,
    franchised_stores int,
    company_stores int,
    total_units_2021 int,
    total_change_units_from_2020 int    
);

LOAD DATA LOCAL INFILE 'C:/MSBA/Data Technology/Top 50 Fast-Food Chains in USA.csv'
INTO TABLE yelp.Top_50_Restaurant_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(fast_food_chains, america_systemwide_sales_millions_usd, avg_sales_per_unit_thousands_usd, franchised_stores, company_stores, total_units_2021, total_change_units_from_2020);

SELECT 
    t.fast_food_chains,
    t.america_systemwide_sales_millions_usd,
    t.avg_sales_per_unit_thousands_usd,
    t.franchised_stores,
    t.company_stores,
    t.total_units_2021,
    t.total_change_units_from_2020,
    b.business_id,
    b.name AS business_name,
    b.city,
    b.state,
    b.stars,
    b.review_count
FROM Top_50_Restaurant_data t
INNER JOIN business b 
ON t.fast_food_chains = b.name;

SELECT 
    t.fast_food_chains,
    t.america_systemwide_sales_millions_usd,
    t.avg_sales_per_unit_thousands_usd,
    t.franchised_stores,
    t.company_stores,
    t.total_units_2021,
    t.total_change_units_from_2020,
    b.business_id,
    b.name AS business_name,
    b.city,
    b.state,
    b.stars,
    b.review_count,
    c.category_name
FROM Top_50_Restaurant_data t
INNER JOIN business b 
ON t.fast_food_chains = b.name
INNER JOIN category c
ON b.business_id = c.business_id;


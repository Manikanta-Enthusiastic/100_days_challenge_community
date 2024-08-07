-- Day 9/100 days challenge

-- Step 1: Create Tables

-- 1.1 Create `drivers` Table
DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(100),
    driver_rating FLOAT,
    join_date DATE
);

-- 1.2 Create `passengers` Table

DROP TABLE IF EXISTS passenger;
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(100),
    passenger_rating FLOAT,
    join_date DATE
);

-- 1.3 Create `rides` Table
DROP TABLE IF EXISTS rides;
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    passenger_id INT,
    ride_date DATE,
    ride_distance FLOAT,
    ride_cost FLOAT,
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id)
);

-- Step 2: Insert Data

-- 2.1 Insert into `drivers` Table
INSERT INTO drivers (driver_id, driver_name, driver_rating, join_date) VALUES
(1, 'John Doe', 4.8, '2022-01-15'),
(2, 'Jane Smith', 4.5, '2021-07-22'),
(3, 'Bob Johnson', 4.9, '2020-11-30');

-- 2.2 Insert into `passengers` Table
INSERT INTO passengers (passenger_id, passenger_name, passenger_rating, join_date) VALUES
(1, 'Alice Brown', 4.7, '2022-03-11'),
(2, 'Charlie Green', 4.6, '2021-09-19'),
(3, 'David White', 4.8, '2020-05-25');

-- 2.3 Insert into `rides` Table
INSERT INTO rides (ride_id, driver_id, passenger_id, ride_date, ride_distance, ride_cost) VALUES
(1, 1, 1, '2023-06-01', 12.5, 25.0),
(2, 2, 2, '2023-06-02', 8.0, 16.0),
(3, 3, 3, '2023-06-03', 10.2, 20.4),
(4, 1, 2, '2023-06-04', 7.5, 15.0),
(5, 2, 3, '2023-06-05', 15.0, 30.0),
(6, 2, 3, '2023-06-07', 15.0, 30.0);


SELECT * FROM passengers;
SELECT * FROM drivers;
SELECT * FROM rides;

-- UBER Asked Questions 
-- Step 3: Interview Questions

-- Question 1: Find the driver with the highest Rating (return driver_name and rating)

SELECT 
    driver_name,
    driver_rating
FROM drivers
ORDER BY driver_rating DESC
LIMIT 1


-- Question 2: Calculate the Total Revenue Generated by Each Driver (return driver_name, id, revenue)



SELECT 
    d.driver_id, -- 1
    d.driver_name, -- 2
    SUM(r.ride_cost) as total_revenue,
    COUNT(*) as no_rides
FROM drivers as d
JOIN 
rides as r
ON r.driver_id = d.driver_id
GROUP BY 1, 2


SELECT 
    d.driver_id, -- 1
    d.driver_name, -- 2
    SUM(r.ride_cost) as total_revenue,
    COUNT(*) as no_rides
FROM drivers as d
JOIN 
rides as r
ON r.driver_id = d.driver_id
GROUP BY d.driver_id, d.driver_name


-- Question 3: Find the Passenger with the Highest Number of Rides (return passenger_name, id, no of rides)

WITH ranks_table
AS
(
    SELECT 
        p.passenger_id,
        p.passenger_name,
        COUNT(r.*) as no_rides,
        RANK() OVER(ORDER BY COUNT(r.*) DESC) as ranks
    FROM passengers as p
    JOIN 
    rides as r
    ON p.passenger_id = r.passenger_id
    GROUP BY 1, 2
    ORDER BY 3 DESC 
)
SELECT 
    passenger_id,
    passenger_name,
    no_rides
FROM ranks_table
WHERE ranks = 1

-- Question 4: Identify the Most Frequent Ride Distance (return ride_distance and number of frequency)

SELECT 
    ride_distance,
    COUNT(*) as frequency
FROM rides
GROUP BY 1
ORDER BY frequency DESC
LIMIT 1





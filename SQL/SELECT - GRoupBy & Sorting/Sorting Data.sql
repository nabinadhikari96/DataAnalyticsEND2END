--1. find the top 5 Samsung phones with the biggest screen size
SELECT model,screen_size  FROM udus.smartphones 
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC LIMIT 5

--2. sort all the phones in descending order of the number of total cameras
SELECT model,num_front_cameras+num_rear_cameras Total_Cameras FROM udus.smartphones 
ORDER BY Total_Cameras DESC

--3. sort data on the basis of ppi in decreasing order
SELECT model, ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height)/screen_size) PPI FROM udus.smartphones
ORDER BY PPI DESC

--4. find the phone with 2nd largest battery
SELECT model,battery_capacity FROM udus.smartphones
ORDER BY battery_capacity DESC LIMIT 1,1

--5. find the name and rating of the worst rated apple phone
SELECT model,rating FROM udus.smartphones
 WHERE brand_name='apple'
 ORDER BY rating ASC LIMIT 1
 
 SELECT * FROM udus.smartphones ORDER BY brand_name ASC,price DESC
 
--6. sort phones alphabetically and then on the basis of rating in desc order
SELECT * FROM udus.smartphones ORDER BY brand_name ASC,rating DESC 

--7.sort phones alphabetically and then on the basis of price in ascending order
SELECT * FROM udus.smartphones ORDER BY brand_name ASC,price ASC 
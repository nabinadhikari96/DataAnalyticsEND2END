 --1. Group smartphones by brand and get the count, average price, max rating, avg screen size, and avg battery capacity
 SELECT brand_name,COUNT(*) 'num',
 AVG(price) 'avg_price',
 MAX(rating) 'max_rating',
 AVG(screen_size) 'AVGscreen_size',
 AVG(battery_capacity) 'AVGbattery_capacity'
 FROM udus.smartphones
 GROUP BY brand_name
 ORDER BY num DESC
 
--2.Group smartphones by whether they have an NFC and get the average price and rating
SELECT has_nfc,AVG(price),AVG(rating) FROM udus.smartphones GROUP BY has_nfc

 --3.Avg price of 5g phones vs avg price of non 5g phones
 SELECT has_5g ,AVG(price) FROM udus.smartphones GROUP BY has_5g 
 
--4.Analysis of Fast Charging Available
 SELECT fast_charging_available,AVG(price),AVG(rating)  FROM udus.smartphones GROuP BY fast_charging_available
 
--5.Group smartphones by the extended memory available and get the average price
SELECT extended_memory_available,AVG(price),AVG(rating)  FROM udus.smartphones GROuP BY extended_memory_available

--GroupBY on multiple columns
--6. Group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution (rear)
SELECT brand_name,processor_brand,COUNT(*),AVG(primary_camera_rear) FROM udus.smartphones
Group BY brand_name,processor_brand

--7.Find the top 5 most costly phone brands
SELECT brand_name,AVG(price) price FROM udus.smartphones GROUP BY brand_name ORDER BY price DESC LIMIT 5

--8.Which brand makes the smallest-screen smartphones
SELECT brand_name,AVG(screen_size) size FROM udus.smartphones GROUP BY screen_size ORDER BY size ASC LIMIT 1

--9.Group smartphones by the brand, and find the brand with the highest number of models that have both NFC and an IR blaster
SELECT brand_name,COUNT(*) count
 FROM udus.smartphones 
 WHERE has_nfc = 'True' AND has_ir_blaster ='True' GROUP BY brand_name
 ORDER BY count DESC LIMIT 1

--10.Find all Samsung 5g enabled smartphones and find out the avg price for NFC and Non-NFC phones
SELECT brand_name,has_nfc,AVG(price) avg_price
 FROM udus.smartphones 
 WHERE brand_name = 'samsung' GROUP BY has_nfc
 

 
 

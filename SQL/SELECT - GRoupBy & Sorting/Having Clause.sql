--1.Costliest Brand which has at least 20 phones.
SELECT brand_name ,COUNT(*) cnt,MAX(price) FROM udus.smartphones GROUP BY brand_name HAVING cnt > 20 LIMIT 1

--2.find the avg rating of smartphone brands that have more than 20 phones
SELECT brand_name ,COUNT(*) cnt,AVG(rating) FROM udus.smartphones GROUP BY brand_name HAVING cnt > 20 
ORDER BY AVG(rating) DESC

--3. Find the top 3 brands with the highest avg ram that has a refresh rate of at least 90 Hz and fast charging available and don't consider brands that have less than 10 phones
SELECT brand_name ,COUNT(*) cnt,AVG(ram_capacity) avg_ram,fast_charging_available ,refresh_rate
FROM udus.smartphones 
WHERE refresh_rate > 90  AND fast_charging_available = '1'
GROUP BY brand_name
 HAVING cnt > 10
 ORDER BY avg_ram DESC
 LIMIT 3


--4.Find the avg price of all the phone brands with avg rating of 70 and num_phones more than 10 among all 5g enabled phones
SELECT brand_name,COUNT(*) cnt,AVG(price) avg_price ,AVG(rating) rating
FROM udus.smartphones 
WHERE has_5g = 'True' 
GROUP BY brand_name 
HAVING cnt >10 AND rating>70 
ORDER BY avg_price DESC
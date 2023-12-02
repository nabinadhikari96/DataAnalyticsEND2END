#There is csv data called smartphones
-- CREATE
INSERT INTO udus.users(user_id,name,email,password)
VALUES (NULL,'xtreme','xtreme@gmail.com','486305')
-- SELECT
#1. select all rows & Columns
SELECT *  FROM udus.smartphones

#2. select model,price and rating(Filter)
SELECT model,price,rating FROM udus.smartphones

#3. Rename Columns(alias)
SELECT os Operating 'System', battery_capacity 'MAH' from udus.smartphones

#4. create Mathematical expression using cols
SELECT model,
SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size as PPI
FROM udus.smartphones

#5. Constatnts
SELECT model, 'smartphone' as 'Type' from udus.smartphones

#6. Distinct(Unique)
select DISTINCT(brand_name) as 'all_brand' from udus.smartphones
select DISTINCT brand_name,processor_brand as 'all_brand' from udus.smartphones

#7. filter rows where clause
#i.find all samsung phones
SELECT * from udus.smartphones WHERE brand_name = 'samsung'
#ii. find all the phones that price > 50,000
SELECT * FROM udus.smartphones where price > 50000

#8. Between
#i. find all the phones price between 10000 to 20000
SELECT * FROM udus.smartphones WHERE price BETWEEN 10000 AND 20000
--ii. find phones with rating >80 and price <25000
SELECT * FROM udus.smartphones where rating > 80 and price < 25000
--iii. find samsung phones of ram > 8
SELECT * FROM udus.smartphones where brand_name ='samsung' and ram_capacity >8

#9. Query Execution order
FJWGHSDO
#10. IN and NOT IN
SELECT * FROM udus.smartphones where processor_brand IN ('snapdragon','exynos','bionic')

--UPDATE
UPDATE udus.smartphones
SET processor_brand ='dimensity'
WHERE processor_brand ='mediatek'

--DELETE
DELETE FROM udus.smartphones WHERE price > 200000
DELETE FROM udus.smartphones WHERE num_rear_cameras > 150 AND brand_name ='samsung'

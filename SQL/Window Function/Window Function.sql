use database;
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51)


- HIGHEST MARK AND LOWEST MARK
SELECT *,AVG(marks) OVER(PARTITION BY branch) avg_m FROM marks

SELECT *,
 MIN(marks) OVER(),
MAX(marks) OVER(),
MIN(marks) OVER(PARTITION BY branch),
MAX(marks) OVER(PARTITION BY branch)
FROM marks

--Aggregate Function with OVER()
--Find all the students who have marks higher than the avg marks of
their respective branch
SELECT * FROM (SELECT *,AVG(marks) OVER(PARTITION BY branch) avg_branch FROM marks) t
WHERE t.marks > t.avg_branch

--RANK/DENSE_RANK/ROW_Number
SELECT *,
CONCAT(branch,'-',RANK() OVER(PARTITION BY branch ORDER BY marks DESC)),
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC),
ROW_NUMBER() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks
1.Find top 2 most paying customers of each month
SELECT * FROM (SELECT MONTHNAME(date) month, user_id,SUM(amount) AS total,
				RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) month_rank
                FROM orders
                GROUP BY MONTHNAME(date),user_id
                ORDER BY MONTH(date)) t
                WHERE t.month_rank < 3
                ORDER BY month DESC,month_rank ASC

2.Create roll no from branch and marks

--FIRST_VALUE/LAST_VALUE/NTH_VALUE
SELECT * ,
FIRST_VALUE(marks) OVER(ORDER BY marks DESC),
LAST_VALUE(marks) OVER(ORDER BY marks DESC
						ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
NTH_VALUE(name,2) OVER(ORDER BY marks DESC
						ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)                        
FROM marks
-------------------
SELECT * FROM (SELECT * ,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) topper_name,
FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) topper_marks
FROM marks) t
WHERE t.name=t.topper_name AND t.marks = t.topper_marks

ANOTHER WAY OF DOING
SELECT *
FROM (
    SELECT *,
        FIRST_VALUE(name) OVER w AS topper_name,
        FIRST_VALUE(marks) OVER w AS topper_marks
    FROM marks
    WINDOW w AS (PARTITION BY branch ORDER BY marks DESC)
) t
WHERE t.name = t.topper_name AND t.marks = t.topper_marks;

LEAD & LAG
SELECT *,
LAG(marks) OVER(PARTITION BY branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM marks

Find the MoM revenue growth of Zomato
SELECT MONTHNAME(date),SUM(amount),
((SUM(amount)-LAG(SUM(amount)) OVER (ORDER BY MONTH(date)))/LAG(SUM(amount)) OVER (ORDER BY MONTH(date)))*100
FROM orders
GROUP BY MONTHNAME(date)
ORDER BY MONTH(date) ASC

--RANKING
Q. TOP 5 BatsMan from each batting ipl team
SELECT * FROM campusx.ipl;

SELECT * FROM (SELECT BattingTeam,batter,SUM(batsman_run) AS 'total_runs',
DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS 'rank_within_team'
FROM ipl
GROUP BY BattingTeam,batter) t
WHERE t.rank_within_team < 6
ORDER BY t.BattingTeam,t.rank_within_team;

--CUMMULATIVE SUM and CUMMULATIVE AVERAGE and RUNNING AVERAGE
Q. Virat Kholi run,avg_run,running_avg
SELECT * FROM (SELECT 
CONCAT("Match-",CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER w AS 'career_runs',
AVG(SUM(batsman_run)) OVER w AS 'career_avg',
AVG(SUM(batsman_run)) OVER(ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS 'rolling_avg'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
WINDOW w AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) t

--PERCENT OF TOTAL
SELECT f_name,
(total_value/SUM(total_value) OVER())*100 AS 'percent_of_total'
FROM (SELECT f_id,SUM(amount) AS 'total_value' FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
WHERE r_id = 5
GROUP BY f_id) t
JOIN food t3
ON t.f_id = t3.f_id
ORDER BY (total_value/SUM(total_value) OVER())*100 DESC

--PERCENT CHANGE
SELECT YEAR(Date),QUARTER(Date),SUM(views) AS 'views',
((SUM(views) - LAG(SUM(views)) OVER(ORDER BY YEAR(Date),QUARTER(Date)))/LAG(SUM(views)) OVER(ORDER BY YEAR(Date),QUARTER(Date)))*100 AS 'Percent_change'
FROM youtube_views
GROUP BY YEAR(Date),QUARTER(Date)
ORDER BY YEAR(Date),QUARTER(Date);


SELECT *,
((Views - LAG(Views,7) OVER(ORDER BY Date))/LAG(Views,7) OVER(ORDER BY Date))*100 AS 'weekly_percent_change'
FROM youtube_views;

--PERCENTILE AND QUANTILES
SELECT *,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY marks) OVER(PARTITION BY branch) AS 'median_marks',
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY marks) OVER(PARTITION BY branch) AS 'median_marks_cont'
FROM marks;

--Outlier removal(min marks of students)
SELECT * FROM (SELECT *,
PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY marks) OVER() AS 'Q1',
PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY marks) OVER() AS 'Q3'
FROM marks) t
WHERE t.marks <= t.Q1 - (1.5*(t.Q3 - t.Q1));

--SEGMENTATION USING NTILE
SELECT *,
NTILE(3) OVER(ORDER BY marks DESC) AS 'buckets'
FROM marks;

SELECT brand_name,model,price, 
CASE 
	WHEN bucket = 1 THEN 'budget'
    WHEN bucket = 2 THEN 'mid-range'
    WHEN bucket = 3 THEN 'premium'
END AS 'phone_type'
FROM (SELECT brand_name,model,price,
NTILE(3) OVER(PARTITION BY brand_name ORDER BY price) AS 'bucket' 
FROM database.smartphones) t;

SELECT * FROM (SELECT *,
CUME_DIST() OVER(ORDER BY marks) AS 'Percentile_Score'
FROM marks) t
WHERE t.Percentile_Score > 0.90;

--Partition By multiple
SELECT * FROM (SELECT source,destination,airline,AVG(price) AS 'avg_fare',
DENSE_RANK() OVER(PARTITION BY source,destination ORDER BY AVG(price)) AS 'rank'
FROM flights
GROUP BY source,destination,airline) t
WHERE t.rank < 2

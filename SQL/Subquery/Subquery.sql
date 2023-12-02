use subquery;
SELECT * FROM movies
WHERE score=(SELECT MAX(score) FROM movies)

--INDEPENDENT SUBQUERY - SCALAR SUBQUERY
--1. Find the movies with highest profit
SELECT * FROM movies
WHERE (gross-budget) = (SELECT MAX(gross-budget)
                        FROM movies);

--2. Find how many movies have a rating > the avg of all the movie rating
SELECT COUNT(*) FROM movies
WHERE score>(SELECT AVG(score)
             FROM movies);

--3.FInd the highest rated movie of 2000
SELECT * FROM movies
WHERE year =2000 AND score = (SELECT MAX(score)
                              FROM movies 
                              WHERE year=2000);

--4. Find the highest rated movie among all the movies whose number of votes are >the dataset avg votes
SELECT * FROM movies
WHERE score=(SELECT MAX(score) FROM movies
             WHERE votes > (SELECT AVG(votes)
                            FROM movies))
                          
                
--INDEPENDENT SUBQUERY - ROW SUBQUERY(ONE COLUMN MULTI ROWS)
--1.Find all user who never ordered
SELECT * FROM users
WHERE user_id NOT IN (SELECT DISTINCT(user_id)
                      FROM orders)

--2.Find all the movies made by top 3 director(in terms of total gross income)
SELECT * FROM movies
WHERE director IN (SELECT director
                   FROM movies
                   GROUP BY director
                   ORDER BY SUM(gross) DESC
                   LIMIT 3)
                   
WITH top_directors AS (SELECT director
                   FROM movies
                   GROUP BY director
                   ORDER BY SUM(gross) DESC
                   LIMIT 3))   
SELECT * FROM movies
WHERE director IN (SELECT * FROM top_directors)                   

--3. Find all movies of those actors who filmography avg rating >8.5(take 25000 votes as cutoff)
SELECT * FROM movies
WHERE star IN (SELECT star FROM movies
				WHERE votes > 25000
				 GROUP BY star
				 HAVING AVG(score) > 8.5);              
              
-- INDEPENDENT SUBQUERY - TABLE SUBQUERY(MULTI COL MULTI ROW) 
--1. Find the most profitable movie of each year
SELECT * FROM movies
WHERE (year,gross-budget) IN (SELECT year,MAX(gross-budget)
								FROM movies
                                GROUP BY year)
                                
--2. Find the highest rated movie of each genre votes cutoff of 25000
SELECT * FROM movies
WHERE (genre,score) IN (SELECT genre,MAX(score)
								FROM movies
                                WHERE votes > 25000
                                GROUP BY genre)
AND votes > 25000                                

--3. Find the highest grossing movies of top 5 actor/director combo in terms of total gross income 
SELECT * FROM movies
WHERE (star,director,gross) IN (SELECT star,director,MAX(gross)
FROM movies
GROUP BY star,director
ORDER BY SUM(gross) DESC LIMIT 5)

WITH top_duos AS (
	SELECT star,director,MAX(gross)
	FROM movies
	GROUP BY star,director
	ORDER BY SUM(gross) DESC LIMIT 5
    )
SELECT * FROM movies 
WHERE (star,director,gross) IN (SELECT * FROM top_duos)    


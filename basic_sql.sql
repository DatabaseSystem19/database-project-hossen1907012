--()

-- most watched movie count

SELECT max(count(mid)) FROM watch_history GROUP BY mid;

-- most wathed movies

with tmpTable (movie_id, view_count) AS
    (SELECT mid, count(mid) FROM watch_history GROUP BY mid)
SELECT movie_id, view_count FROM tmpTable;


-- find movie names and publishing date with 'The'
SELECT title, publishing_date FROM movie WHERE title LIKE '%The%';


-- publisher's name to find movie names

SELECT title FROM movie WHERE publisher= (SELECT id FROM publisher WHERE fullname='Columbia Pictures');


-- Users watched more than 10 movies. Output ordered by userid
WITH temptable(usr_id, count_mvid) AS (SELECT user_id, count(mid) FROM watch_history GROUP BY user_id ORDER BY user_id) SELECT (SELECT fullname FROM users WHERE id=T.usr_id) FROM temptable T WHERE count_mvid > 10;

-- Users watched exactly 4 publishers
SELECT user_id, count(distinct publisher) FROM watch_history INNER JOIN movie ON watch_history.mid=movie.id GROUP BY user_id having count(distinct publisher)=4 ORDER BY user_id;


-- total revenue
SELECT sum(amount) AS total_revenue FROM payment;

-- maximum payment of a day
WITH tmptable(pday, tot_amnt) as (SELECT payment_date, sum(amount) AS total_revenue FROM payment GROUP BY payment_date) SELECT max(tot_amnt) FROM tmptable;


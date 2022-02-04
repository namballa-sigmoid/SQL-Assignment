
USE practice;

SHOW TABLES;

SELECT COUNT(*) 
FROM airbnb;

ALTER TABLE airbnb
ADD id INT NOT NULL AUTO_INCREMENT KEY;

SELECT *
FROM airbnb;

/*Q1*/

(SELECT date
FROM airbnb
ORDER BY date
LIMIT 1)
UNION
(SELECT date
FROM airbnb
ORDER BY date DESC
LIMIT 1);



/*Q2*/

SELECT listing_id, date, COUNT(*) AS cnt
FROM airbnb
GROUP BY listing_id, date
HAVING COUNT(*)>1;

SELECT *
FROM airbnb AS a1
INNER JOIN airbnb AS a2
WHERE a1.id > a2.id 
AND a1.listing_id = a2.listing_id 
AND a1.date = a2.date; 




/*Q3*/

CREATE TABLE airbnb_avail  (
    listing_id INT,
    available INT,
    not_available INT,
    availability DECIMAL(5,2)
);

INSERT INTO airbnb_avail
SELECT listing_id, SUM(available = 't'), SUM(available = 'f'), SUM(available = 't')/COUNT(*)*100
FROM airbnb
GROUP BY listing_id;

SELECT * FROM airbnb_avail;




/*Q4*/

SELECT COUNT(*) AS CNT
FROM airbnb_avail
WHERE availability > 50;


SELECT COUNT(*) AS CNT
FROM airbnb_avail
WHERE availability > 75;




/*Q5*/

UPDATE airbnb
SET price = NULL
WHERE price = ' ' OR price = '' OR price = '$' OR price = '$0' OR price = '0';

UPDATE airbnb
SET price = TRIM(LEADING '$' FROM price);

UPDATE airbnb
SET price=CAST(price AS DECIMAL(6,2));

ALTER TABLE airbnb
MODIFY price DECIMAL(6,2);

SELECT listing_id, MAX(price) AS Maximum, MIN(price) AS Minumum, AVG(price) as Average
FROM airbnb
GROUP BY listing_id;

/*Q6*/

SELECT listing_id, AVG(price)
FROM airbnb
GROUP BY listing_id
HAVING AVG(price)>500;



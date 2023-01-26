-- Restaurant Owners
-- 5 Tables
-- 1x Fact, 4x Dimension
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery / with


-- Start customer
-- dim customer

CREATE TABLE customers (
  customer_id INT UNIQUE PRIMARY KEY,
  firstname TEXT ,
  lastname TEXT,
  sex_id INT,
  age INT,
  occupation_id INT,
    
  foreign key (sex_id) references
  sex(sex_id),
  foreign key  (occupation_id) references
  occupation(occupation_id)
);

INSERT INTO customers VALUES
  (1, 'Toey','Sing', 1, 29, 1),
  (2, 'John','Wick', 1, 35, 2),
  (3, 'John','Mar', 1, 40, 2),
  (4, 'Marry','Lee', 2, 16, 4),
  (5, 'Ringo','Starr', 1, 70, 5),
  (6, 'Maria','Sharapova', 2, 35, 6),
  (7, 'Jenny','Panun', 3, 36, 2),
  (8, 'Sato','Takeshi', 1, 29, 1),
  (9, 'Lisa','BP', 2, 20, 5),
  (10, 'Paul','Mc', 1, 80, 5),
  (11, 'Wai','Jairai', 2, 32, 3),
  (12, 'Wang','Lee', 1, 15, 4),
  (13, 'Lee','Hom', 2, 26, 3),
  (14, 'Micheal','Jordan', 1, 51, 6),
  (15, 'Bua','Kao', 1, 41, 6),
  (16, 'Stamp','Fairtex', 2, 23, 6),
  (17, 'George','Michael', 1, 29, 5),
  (18, 'Jen','Jeno', 2, 40, 1),
  (19, 'Kai','Do', 3, 50, 1),
  (20, 'Tiger','Wood', 1, 46, 6);
-- End dim customer

-- Start sex
-- dim sex
CREATE TABLE sex (
  sex_id INT UNIQUE PRIMARY KEY,
  sex_name TEXT
);

INSERT INTO sex values 
  (1,'Male'),
  (2,'Female'),
  (3,'LGBTQ');
-- END dim sex

-- Start occupation
-- dim occupation
CREATE TABLE occupation(
  occupation_id INT UNIQUE PRIMARY KEY,
  occupation_name TEXT
);

INSERT INTO occupation VALUEs
  (1, 'Salaryman'),
  (2, 'Actor/Actress'),
  (3, 'Teacher'),
  (4, 'Student'),
  (5, 'Singer/Producer'),
  (6, 'Athlete');
-- END dim occupation

--Start food
-- dim food
CREATE TABLE food(
  food_id INT UNIQUE PRIMARY KEY,
  food_name TEXT,
  food_price REAL
);

INSERT INTO food values
  (1,'Kaomunkai', 50.00),
  (2,'Griled Pork', 100.00),
  (3,'Sukiyaki', 200.00),
  (4,'Duck Palo', 150.00),
  (5,'Cheese Board', 200.00),
  (6,'Somtam', 50.00),
  (7,'SushiSet', 200.00),
  (8,'Bingsoo', 80.00);
-- END food

-- Start order
-- fact table
CREATE TABLE orders(
  order_id INT UNIQUE PRIMARY KEY,
  order_date DATE,
  customer_id INT,
  table_no INT,
  food_id INT,

  FOREIGN KEY (customer_id) references
    customers(customer_id)
  FOREIGN KEY (food_id) references
    food(food_id)
);
INSERT INTO orders values
  (1,'2023-1-2', 2, 1, 3),
  (2,'2023-1-2', 2, 1, 4),
  (3,'2023-1-3', 3, 2, 8),
  (4,'2023-1-3', 3, 2, 5),
  (5,'2023-1-3', 3, 2, 5),
  (6,'2023-1-4', 9, 3, 5),
  (7,'2023-1-5', 10, 1, 6),
  (8,'2023-1-5', 20, 2, 6),
  (9,'2023-1-7', 15, 1, 4),
  (10,'2023-1-10', 17, 3, 4),
  (11,'2023-1-10', 17, 3, 4),
  (12,'2023-1-14', 2, 1, 3),
  (13,'2023-1-14', 2, 5, 7),
  (14,'2023-1-14', 13, 1, 2),
  (15,'2023-1-16', 2, 1, 3),
  (16,'2023-1-17', 8, 1, 8),
  (17,'2023-1-18', 1, 1, 6),
  (18,'2023-1-20', 19, 1, 3),
  (19,'2023-1-20', 19, 1, 7),
  (20,'2023-1-20', 19, 1, 5);
  
  
-- sqlite command
.mode markdown
.header on
-- SELECT * FROM orders;
  
-- Query 1
select 
  order_id,
  order_date,
  firstname,
  lastname,
  food_name,
  food_price
from orders
JOIN customers ON customers.customer_id = orders.customer_id
JOIN food ON food.food_id = orders.food_id;

-- Query 2
SELECT
  food_name,
  COUNT(*) AS order_qty
FROM (
  SELECT food_name
  FROM orders
  JOIN food ON food.food_id = orders.food_id
)
GROUP BY 1
ORDER BY 2 DESC;

-- query 3
WITH sub as (
    SELECT
    firstname,
    lastname,
    food_price
  FROM orders
  JOIN customers ON customers.customer_id = orders.customer_id
  JOIN food ON food.food_id = orders.food_id
)

SELECT 
  firstname,
  lastname,
  SUM(food_price) AS spent_amount
FROM sub
GROUP BY 1
ORDER BY 3 DESC

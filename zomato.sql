-- 1. Total amount each customer spent in Zomato
SELECT  
    sales.userid,
    SUM(product.price) AS total_amount
FROM 
    sales
INNER JOIN 
    product ON sales.product_id = product.product_id
GROUP BY 
    sales.userid;

-- 2. How many days each customer visited Zomato
SELECT 
    userid,
    COUNT(DISTINCT created_date) AS visiting_counts
FROM 
    sales
GROUP BY 
    userid;

-- 3. First product purchased by each customer
SELECT *
FROM (
    SELECT 
        *,
        RANK() OVER (PARTITION BY userid ORDER BY created_date) AS rank
    FROM 
        sales
) AS ranked_sales
WHERE 
    rank = 1;

-- 4. Most purchased item and how many times it was purchased by all customers
SELECT 
    product_id, 
    COUNT(*) AS purchase_count
FROM 
    sales
WHERE 
    product_id = (
        SELECT TOP 1 product_id
        FROM sales
        GROUP BY product_id
        ORDER BY COUNT(*) DESC
    )
GROUP BY 
    product_id;

-- 5. Most popular item for each customer
SELECT * 
FROM (
    SELECT 
        userid,
        product_id,  
        COUNT(product_id) AS cnt,
        RANK() OVER (PARTITION BY userid ORDER BY COUNT(product_id) DESC) AS rnk
    FROM 
        sales
    GROUP BY 
        userid, product_id
) AS ranked_sales 
WHERE 
    rnk = 1;

-- 6. Item purchased first by the customer after they became a member
SELECT * 
FROM (
    SELECT 
        purchased_item.*,
        RANK() OVER (PARTITION BY userid ORDER BY created_date) AS rnk 
    FROM (
        SELECT 
            sales.userid,
            sales.created_date,
            sales.product_id,
            goldusers_signup.gold_signup_date
        FROM 
            sales
        INNER JOIN 
            goldusers_signup ON sales.userid = goldusers_signup.userid
        WHERE 
            created_date > gold_signup_date
    ) AS purchased_item
) AS ranked 
WHERE 
    rnk = 1;

-- 7. Item purchased just before the customer became a member
SELECT * 
FROM (
    SELECT 
        purchased_item.*,
        RANK() OVER (PARTITION BY userid ORDER BY created_date) AS rnk 
    FROM (
        SELECT 
            sales.userid,
            sales.created_date,
            sales.product_id,
            goldusers_signup.gold_signup_date
        FROM 
            sales
        INNER JOIN 
            goldusers_signup ON sales.userid = goldusers_signup.userid
        WHERE 
            created_date < gold_signup_date
    ) AS purchased_item
) AS ranked 
WHERE 
    rnk = 1;

-- 8. Total orders and amount spent for each customer before they became a member
SELECT 
    userid,
    SUM(price) AS total_price,
    COUNT(created_date) AS total_orders 
FROM (
    SELECT 
        users.*,
        product.price 
    FROM (
        SELECT 
            sales.userid,
            sales.created_date,
            sales.product_id,
            goldusers_signup.gold_signup_date
        FROM 
            sales
        INNER JOIN 
            goldusers_signup ON sales.userid = goldusers_signup.userid
        WHERE 
            created_date < gold_signup_date
    ) AS users 
    INNER JOIN 
        product ON users.product_id = product.product_id
) AS prices_totals
GROUP BY 
    userid;

-- 9. Rank all the transactions of the customers
SELECT *,
    RANK() OVER (PARTITION BY userid ORDER BY created_date) AS rnk
FROM 
    sales;

-- 10. Rank all transactions for each member; mark non-gold member transactions as 'NA'
SELECT 
    c.*, 
    CASE 
        WHEN gold_signup_date IS NULL THEN 'NA'  
        ELSE CAST(RANK() OVER (PARTITION BY userid ORDER BY created_date DESC) AS VARCHAR)
    END AS rnk
FROM (
    SELECT 
        sales.userid,
        sales.created_date,
        sales.product_id,
        goldusers_signup.gold_signup_date
    FROM 
        sales
    LEFT JOIN 
        goldusers_signup ON sales.userid = goldusers_signup.userid
    WHERE 
        created_date >= gold_signup_date
) AS c;

-- 11. Most popular item for each customer (repeated query)
SELECT * 
FROM (
    SELECT 
        userid,
        product_id,  
        COUNT(product_id) AS cnt,
        RANK() OVER (PARTITION BY userid ORDER BY COUNT(product_id) DESC) AS rnk
    FROM 
        sales
    GROUP BY 
        userid, product_id
) AS ranked_sales 
WHERE 
    rnk = 1;

-- 12. Select all from sales
SELECT * FROM sales;

-- 13. Select all from product
SELECT * FROM product;

# Zomato Database

This repository contains SQL scripts to set up and populate a Zomato-like database. It includes tables for users, sales, products, and gold user signups.

## Files

- `zomato.sql`: Contains the SQL commands to create the database tables.
- `zomato_data.sql`: Contains the SQL commands to insert data into the tables.

## Database Schema

### Tables

1. **goldusers_signup**
   - `userid`: Integer, unique identifier for each user.
   - `gold_signup_date`: Date when the user signed up for the gold membership.

2. **users**
   - `userid`: Integer, unique identifier for each user.
   - `signup_date`: Date when the user signed up.

3. **sales**
   - `userid`: Integer, unique identifier for each user.
   - `created_date`: Date when the sale was made.
   - `product_id`: Integer, identifier for the product sold.

4. **product**
   - `product_id`: Integer, unique identifier for each product.
   - `product_name`: Text, name of the product.
   - `price`: Integer, price of the product.

## SQL Queries

1. **What is the total amount each customer spent in Zomato?**

2. **How many days each customer visited Zomato?**

3. **What was the first product purchased by each customer?**

4. **What is the most purchased item and how many times was it purchased by all customers?**

5. **What is the most popular item for each customer?**

6. **What item was purchased first by the customer after they became a member?**

7. **What item was purchased just before the customer became a member?**

8. **What is the total number of orders and amount spent for each customer before they became a member?**

9. **How can I rank all the transactions of the customers?**

10. **How can I rank all transactions for each member and mark non-gold member transactions as 'NA'?**

11. **What is the most popular item for each customer?**

12. **How can I select all from the sales table?**

13. **How can I select all from the product table?**

## Usage

1. **Set up the database**:
   - Run the commands in `zomato_data.sql` to create the tables.
   
  

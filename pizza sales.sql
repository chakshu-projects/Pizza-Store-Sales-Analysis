SELECT * FROM pizza_store.pizzas;
use pizza_store;
-- 1. Retrieve the total number of order placed?
 select count(Order_id) from order_pizza; 
 
-- 2.Calculate the total revenue generated from pizza sales?
 select sum(quantity * price) as Total_revenue from order_details left join pizzas on order_details.pizza_id=pizzas.pizza_id; 
-- 3.identify the highest price pizza?
 select name, max(price) as highest_price_pizza from pizzas join pizza_type on pizzas.pizza_type_id=pizza_type.type_id group by name order by highest_price_pizza desc limit 1;
 
-- (the greek pizza = 35.95)

-- 4.Identify the most common pizza size ordered?
SELECT 
    pizzas.size, SUM(order_details.quantity) AS total_order
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY size
ORDER BY total_order DESC
LIMIT 1;
-- 6.join the necessary tables to find the total quantity of each pizza category ordered?
SELECT 
    pizza_type.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_type ON pizza_type.type_id = pizzas.pizza_type_id
GROUP BY pizza_type.category
ORDER BY total_quantity DESC;
-- 5.list the top 5 most ordered pizza types along with their quantite
 select pizza_type.name Most_ordered_pizza, sum(order_details.quantity) as Total_Quantity from order_details
        JOIN
        pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_type ON pizza_type.type_id = pizzas.pizza_type_id group by name order by Total_Quantity desc limit 5;

-- 7.determine the distribution of orders by hour of the day?
 select hour(time_of_order) as time_order, count(order_id) as no_of_order from order_pizza group by time_order order by time_order asc;

-- 8. Join relevant tables to find the category-wise distribution of pizzas?
SELECT 
    pizza_type.category AS Category,
    SUM(order_details.quantity) AS Total_quantity
FROM
    order_details
        JOIN
     pizzas ON order_details.pizza_id = pizzas.pizza_id
     join
     pizza_type ON pizza_type.type_id = pizzas.pizza_type_id
GROUP BY Category
ORDER BY Total_quantity DESC;
-- 10. determine the top 3 most ordered pizza types based on revenue?
SELECT 
    pizza_type.name AS PIZZA_TYPES,
    SUM(order_details.quantity * pizzas.price) AS Revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_type ON pizza_type.type_id = pizzas.pizza_type_id
GROUP BY PIZZA_TYPES
ORDER BY revenue DESC
LIMIT 3;

-- 9.group the orders by date and calculate the average number of pizzas ordered per day?

select date(order_pizza.date_of_order) as ordered_date, avg(order_details.quantity) as Average_orders FROM
    order_details
        JOIN
    order_pizza on order_details.orders_id=order_pizza.Order_id
GROUP BY ordered_date
order by ordered_date asc;

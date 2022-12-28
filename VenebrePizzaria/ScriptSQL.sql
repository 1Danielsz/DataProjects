-- ------------------------ Quais foram os top 3 meses com maior faturamento ------------------------
SELECT EXTRACT(MONTH FROM orders.datet) AS mes, SUM(order_details.quantity * pizzas.price) AS faturamento
FROM order_details
INNER JOIN orders
ON orders.order_id = order_details.order_id
INNER JOIN pizzas
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY mes
ORDER BY faturamento DESC
LIMIT 3;



-- ------------------------ Qual foi o top3 tipo de pizza mais vendido? ------------------------
SELECT name, SUM(quantity) AS total_quantity
FROM order_details
INNER JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
INNER JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY total_quantity DESC
LIMIT 3;



-- ------------------------ Qual foi o top3 tipo de pizza com mais faturamento? ------------------------
SELECT pizza_types.name, SUM(pizzas.price * order_details.quantity) AS total_revenue
FROM order_details
INNER JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
INNER JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;

-- ------------------------ Qual é o preço médio  por pedido? ------------------------
SELECT AVG(total_price) AS avg_price_per_order
FROM (
  SELECT order_id, SUM(quantity * price) AS total_price
  FROM order_details
  INNER JOIN pizzas
  ON pizzas.pizza_id = order_details.pizza_id
  GROUP BY order_id
) t


-- ------------------------ Qual é o faturamento por trimestre? ------------------------
SELECT 
       CASE
           WHEN EXTRACT(MONTH FROM orders.datet) IN (1, 2, 3) THEN '1º Trimestre'
           WHEN EXTRACT(MONTH FROM orders.datet) IN (4, 5, 6) THEN '2º Trimestre'
           WHEN EXTRACT(MONTH FROM orders.datet) IN (7, 8, 9) THEN '3º Trimestre'
           ELSE '4º Trimestre'
       END AS trimestre,
       SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM order_details
INNER JOIN orders
ON orders.order_id = order_details.order_id
INNER JOIN pizzas
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY trimestre;

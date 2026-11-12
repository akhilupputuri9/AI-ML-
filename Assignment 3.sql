#1.display all customer details who have made more than 5 payments.

SELECT * FROM customer
WHERE customer_id IN (
SELECT customer_id FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id)>5);

#2. Find the names of actors who have acted in more than 10 films.

SELECT actor_id,first_name,last_name FROM actor 
WHERE actor_id IN (
SELECT actor_id 
FROM film_actor
GROUP BY actor_id,first_name,last_name
HAVING COUNT(film_id)>10);

#3. Find the names of customers who never made a payment.

SELECT first_name,last_name FROM customer 
WHERE customer_id NOT IN (
SELECT customer_id 
FROM payment);

#4. List all films whose rental rate is higher than the average rental rate of all films.

SELECT title,rental_rate FROM film 
WHERE rental_rate > (
SELECT AVG(rental_rate) 
FROM film);
#5. List the titles of films that were never rented.

SELECT title FROM film 
WHERE film_id NOT IN (
SELECT i.film_id FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id);

#6. Display the customers who rented films in the same month as customer with ID 5.

WITH customer_5month AS (SELECT DISTINCT MONTH(rental_date) AS rental_month
FROM rental
WHERE customer_id = 5
)
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN customer_5month cm ON MONTH(r.rental_date) = cm.rental_month
WHERE c.customer_id != 5;

#7. Find all staff members who handled a payment greater than the average payment amount.

WITH AvgPayment AS (SELECT AVG(amount) AS avg_amt FROM payment)
SELECT DISTINCT s.staff_id, s.first_name, s.last_name FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
CROSS JOIN AvgPayment ap
WHERE p.amount > ap.avg_amt;

#8. Show the title and rental duration of films whose rental duration is greater than the average.

WITH AvgDuration AS (SELECT AVG(rental_duration) AS avg_dur FROM film)
SELECT title, rental_duration
FROM film, AvgDuration
WHERE rental_duration > avg_dur;

#9. Find all customers who have the same address as customer with ID 1.

SELECT customer_id,first_name,last_name,address_id 
FROM sakila.customer 
WHERE address_id=(SELECT address_id FROM customer WHERE customer_id=1) AND customer_id >1;


#10. List all payments that are greater than the average of all payments.

WITH avg_payment AS (
SELECT AVG(amount) AS avg_amount 
FROM payment)
SELECT payment_id, customer_id, rental_id, amount 
FROM payment 
WHERE amount > (SELECT avg_amount FROM avg_payment);
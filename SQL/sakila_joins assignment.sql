#List all customers along with the films they have rented.
SELECT 
c.customer_id,c.first_name,c.last_name,c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i on r.inventory_id = i.inventory_id
JOIN film f on i.film_id = f.film_id
ORDER BY c.first_name,c.last_name,c.email,f.film_id;

# List all customers and show their rental count, including those who haven't rented any films.
SELECT 
c.customer_id,c.first_name,c.last_name,c.email,COUNT(rental_id) AS rental_count
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name,c.email
ORDER BY c.first_name,c.last_name,c.email;

#Show all films along with their category. Include films that don't have a category assigned.

SELECT 
f.film_id,f.title,c.name AS category_name
FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
ORDER BY f.film_id,f.title;

#Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).

SELECT 
c.customer_id,c.first_name,c.last_name
FROM customer c
LEFT JOIN staff s ON c.store_id =s.store_id
UNION
SELECT 
c.customer_id,c.first_name,c.last_name
FROM customer c
RIGHT JOIN staff s ON c.store_id = s.store_id; 

# Find all actors who acted in the film "ACADEMY DINOSAUR".

SELECT 
a.actor_id,a.first_name,a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id =fa.actor_id
JOIN film f ON fa.film_id=f.film_id
WHERE f.title="ACADEMY DINOSAUR";

#List all stores and the total number of staff members working in each store, even if a store has no staff.

SELECT 
s.store_id,COUNT(sf.staff_id)AS total_staff
FROM store s
LEFT JOIN staff sf On s.store_id=sf.store_id
GROUP BY s.store_id;

#List the customers who have rented films more than 5 times. Include their name and total rental count.
SELECT
c.customer_id,c.first_name,c.last_name,COUNT(rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
HAVING COUNT(r.rental_id)>5;
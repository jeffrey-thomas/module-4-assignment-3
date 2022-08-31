-- 1 - List all customers who live in Texas (use JOINs)

select first_name, last_name
from customer
full join address
on customer.address_id = address.address_id
where address.district = 'Texas'

-- 2 - Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name, amount
from customer
full join payment
on customer.customer_id = payment.customer_id 
where payment.amount > 6.99

-- 3 - Show all customers names who have made payments over $175 (use subqueries)
select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 175
)

-- 4 - List all customers that live in Nepal (use the city table)
select first_name, last_name
from customer
inner join address
on customer.address_id = address.address_id 
inner join city
on address.city_id = city.city_id 
inner join country
on city.country_id = country.country_id 
where country.country = 'Nepal'

-- 5 - Which staff member had the most transactions?

select first_name, last_name
from staff
where staff_id in (
	select staff_id
	from payment
	group by staff_id
	having count(staff_id) = ( 
		-- get the maximum count of any staff_id
		select max(num)
		from(
			select count(staff_id) as num
			from payment
			group by staff_id
		) staff_counts
	)
)

-- 6 - How many movies of each rating are there?

select rating, count(rating)
from film
group by rating

-- 7 - Show all customers who have made a single payment above $6.99 (Use subqueries)
select distinct first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
)

-- 8 - How many free rentals did our stores give away?
select count(payment_id)
from payment
where amount < 0.01
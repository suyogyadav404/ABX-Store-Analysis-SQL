'understanding and exploring the data presented in each table '

select * from categories
select * from customers limit 5
select * from states
select * from orders limit 5
select * from products
select * from salespersons
select * from statuses

' DATA ANALYSIS PROCESS '

'Q1. List Top 3 products by revenue'

select p.id as Product_id, p.name as Product_Name, sum(o.revenue) as Revenue 
from products p
inner join orders o 
on p.id = o.product_id
group by p.id , Product_Name 
order by Revenue desc
limit 3

'Q2. Show Top 3 months by Revenue. '

select extract(month from o.order_date) as Order_Month, sum(o.revenue) as Revenue from orders o
group by Order_Month
order by Revenue desc
limit 3

' Q3. Show Top 3 states where Top 3 items are purchased in high quantity. '

select st.name as statenames
from orders o
inner join customers c 
on c.id = o.customer_id
inner join states st 
on st.id = c.state_id
where o.product_id IN
(
	select o.product_id
	from orders o
	group by o.product_id
	order by sum(revenue)  desc
	limit 3
)
group by st.name
order by sum(o.quantity) desc
limit 3

' Q.4 Show which Age group generated more revenue in Top 3 states'

select 
CASE 
	when c.age <= 30 then '15 - 30 age group'
	when c.age between 31 and 50 then '31 - 50 age group'
	when c.age > 50 then 'above 50 age group'
END as age_group,
sum(o.revenue) as revenue 
from orders o
inner join customers c
on c.id = o.customer_id
where c.state_id IN
(
	select st.id
	from orders o
	inner join customers c 
	on c.id = o.customer_id
	inner join states st 
	on st.id = c.state_id
	where o.product_id IN
	(
		select o.product_id
		from orders o
		group by o.product_id
		order by sum(revenue)  desc
		limit 3
	)
	group by st.id
	order by sum(o.quantity) desc
	limit 3
)
group by age_group
order by revenue desc
limit 1

















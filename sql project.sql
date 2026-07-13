create database retailsales;
select * from retailsales.brands;
select * from retailsales.categories;
select * from retailsales.customers1;
select * from retailsales.order_items;
select * from retailsales.orders1;
select * from retailsales.products1;
select * from retailsales.staffs;
select * from retailsales.stocks;	
select * from retailsales.stores;

-- task 3
select * from retailsales.orders1
inner join retailsales.order_items,retailsales.products1;

-- task 4
select a.store_id,sum(b.list_price) as totalsales from retailsales.stocks as a
inner join retailsales.products1 b on  a.product_id=b.product_id group by store_id order by totalsales;

-- task 5
select a.product_name,sum(b.quantity) as total_quantity from retailsales.products1 as a
inner join retailsales.stocks b on a.product_id=b.product_id group by product_name order by total_quantity desc limit 5;

-- task 6
select c.customer_id,concat(c.first_name,c.last_name) as customer_name,count(distinct o.order_id) as total_orders,
sum(oi.quantity) as total_itms_purchased,sum((oi.list_price*oi.quantity)-oi.discount) as total_revenue from retailsales.customers1 c
join retailsales.orders1 o on c.customer_id=o.customer_id
join retailsales.order_items oi on o.order_id=oi.order_id group by c.customer_id,customer_name order by total_revenue desc;

-- task 7
select c.customer_id,concat(c.first_name,'',c.last_name) as customer_name,
sum((oi.list_price*oi.quantity)-oi.discount) as total_spend,
 CASE
    WHEN 
 sum((oi.list_price*oi.quantity)-oi.discount)<1000 then 'low'
 when
 sum((oi.list_price*oi.quantity)-oi.discount) between 1000 and 5000 then 'medium'
else 'high'
 end as spending_segment from retailsales.customers1 c
join retailsales.orders1 o on c.customer_id=o.customer_id
join retailsales.order_items oi on o.order_id=oi.order_id group by c.customer_id,c.first_name,c.last_name order by total_spend desc;

-- task 8
select s.staff_id,concat(s.first_name,s.last_name) as staff_name,count(distinct o.order_id) as total_orderds,
sum((oi.list_price*oi.quantity)-oi.discount) as total_revenue from retailsales.staffs s
join retailsales.orders1 o on s.staff_id=o.staff_id 
join retailsales.order_items oi on o.order_id=oi.order_id group by s.staff_id,s.first_name,s.last_name order by total_revenue desc;

-- task 9
select p.product_id,p.product_name,s.store_id,s.quantity from retailsales.products1 p
join retailsales.stocks s on p.product_id=s.product_id where quantity< 10 order by s.quantity asc;

-- task 10
create table retailsales.customersegments(
customer_id int primary key, customer_name varchar(100),total_spend decimal(10,2),
spending_segment varchar(30));

select * from retailsales.customersegments;
drop table retailsales.customersegments;

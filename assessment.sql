select * from authors

select * from publishers

select * from sales

----1
select city , count(au_id)No_Of_Authors from authors group by city



-----2
select au_fname,au_lname,city from authors
where city in (select city from publishers where pub_name!='New Moon Books')



-----3

create proc proc_priceUpdate(@fname varchar(20), @lname varchar(20), @n_price varchar(20))
as 
begin
update titles set price=@n_price where title_id in
(select title_id from titleauthor where au_id in
(select au_id from authors where au_fname = @fname and au_lname = @lname))
end

exec proc_priceUpdate 'ramu','red','100'

select * from titles




-----4
create function fn_PrintingTax(@quantity int)
returns float
as
begin
declare
@tax int
if(@quantity < 10)
set @tax=2
else if(@quantity>=10 and @quantity<=20)
set @tax=5
else if(@quantity>=21 and @quantity<=30)
set @tax=6
else
set @tax=7.5
return @tax
end

select qty,dbo. fn_PrintingTax(qty) 'Tax' from sales

select * from dbo.fn_PrintingTax(100)

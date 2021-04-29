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
create function fn_PrintingTax(@auid varchar(20))
  returns @TotalTax Table
  (
     Bname varchar(15), 
	 Totalamount float,
	 Tax float)
	as
	begin
	declare
		@total float,
		@tax float,
		@taxPayable float,
		@Bname varchar(15)
		  set @total = (select price from titles ts join authors au
		  on ts.title_id = au.au_id
		  where ts.title_id = @auid )
		  if(@total<10)
			set @tax = 2
		  else if(@total>10 and @total<20)
			set @tax = 5
		  else if(@total>20 and @total<30)
			set @tax = 6
		  else 
			set @tax = 7.5
		  set @taxPayable = @total*@tax/100
		  set @Bname = (select name from tblEmployee_details where id = @auid)
		  insert into @TotalTax values(@Bname,@total,@taxPayable)
		  return
	end

select * from dbo.fn_PrintingTax(100)
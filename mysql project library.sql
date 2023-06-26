/*Create a database named library and create following TABLES in the database: 
1.  Branch 
2.  Employee 
3.  Customer 
4.  IssueStatus 
5.  ReturnStatus 
6.  Books
Branch_no - Set as PRIMARY KEY 
 Manager_Id 
 Branch_address 
 Contact_no

Emp_Id – Set as PRIMARY KEY 
 Emp_name 
 Position 
 Salary*/

create database library;
use library;

create table branch(
branch_no int primary key,
manager_id int ,
branch_address varchar(30),
contact_no varchar(30) );
insert into branch values(123,1,'chalakudy','9496291476');
insert into branch values(124,2,'thrissur','9496291475');
insert into branch values(125,3,'palakkad','9496291474');
insert into branch values(126,4,'irinjalakuda','9496291473');
insert into branch values(127,5,'kollam','9496291472');
select * from branch;

create table employee(emp_id int primary key,
emp_name varchar(30),
position varchar(30),
salary varchar(30));
insert into employee values(2,'reshma','manager','30000');
insert into employee values(4,'greshma','officer','30000');
insert into employee values(5,'jishma','clerk','20000');
insert into employee values(1,'kiara','hr','20000');
insert into employee values(3,'lala','officer','30000');
select * from employee;

create table customer(

Customer_Id int primary key,
 Customer_name varchar(30),
 Customer_address varchar(30),
 Reg_date date);
 
 insert into customer values(101,'bobby','calicut','2020-01-01');
 insert into customer values(102,'olga','mumbai','2021-01-28');
 insert into customer values(103,'liam','delhi','2022-10-01');
 insert into customer values(104,'nuestra','chennai','2023-01-10');
 insert into customer values(105,'jenny','angamaly','2020-02-01');
 
 select * from customer;
 
 create table issuestatus(
 Issue_Id int PRIMARY KEY, 
Issued_cust int ,
Issued_book_name VARCHAR(30),
Issue_date DATE,
ISBN_book VARCHAR(30) NOT NULL,
FOREIGN KEY(Issued_cust) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
FOREIGN KEY(Isbn_book) REFERENCES Books(ISBN) ON DELETE CASCADE
);

insert into issuestatus values(1234,101,'titanic','2020-10-10','9876543210987');
insert into issuestatus values(1235,103,'snow white','2022-01-10','9876543210988');
insert into issuestatus values(1236,105,'tangled','1999-10-01','9876543210989');
insert into issuestatus values(1237,102,'rhymes','2000-02-10','9876543210910');
insert into issuestatus values(1238,104,'genetics','2005-05-10','9876543210900');
select * from issuestatus;

 create table ReturnStatus(
Return_Id int PRIMARY KEY ,
Return_cust int,
Return_book_name varchar(30),
Return_date date,
Isbn_book2 varchar(30),
FOREIGN KEY(Return_cust) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
FOREIGN KEY(ISBN_book2) REFERENCES Books(ISBN) ON DELETE CASCADE
);

insert into ReturnStatus values(4567,105,'rhymes','2000-03-10','9876543210910');
insert into ReturnStatus values(4565,101,'tangled','1999-11-01','9876543210989');
insert into ReturnStatus values(4564,103,'genetics','2005-06-10','9876543210900');
insert into ReturnStatus values(4563,102,'snow white','2022-02-10','9876543210988');
insert into ReturnStatus values(4562,104,'titanic','2020-11-01','9876543210987');

select * from ReturnStatus;

 create table Books( 
ISBN  varchar(30) PRIMARY KEY ,
Book_title varchar(30), 
Category varchar(30),
rental_price DECIMAL(5, 2),
Status VARCHAR(3), 
Author VARCHAR(30),
Publisher VARCHAR(30)
);

insert into books values('9876543210910','rhymes','kids',20.00,'yes','enid blyton','xyz');
insert into books values('9876543210989','tangled','fairytale',25.00,'yes','Jacob Ludwig','abc');
insert into books values('9876543210900','genetics','science',30.00,'no','Leland Hartwel','def');
insert into books values('9876543210988','snow white','fairytale',25.00,'yes','The Brothers Grimm','ghi');
insert into books values('9876543210987','titanic','fiction',40.00,'yes','Filson Young','jkl');

select * from books;
-- 1) Retrieve the book title, category, and rental price of all available books.
select Book_title,Category,rental_price from books where Status='yes';

-- 2) List the employee names and their respective salaries in descending order of salary.
select emp_name,salary from employee order by salary desc;

-- 3)Retrieve the book titles and the corresponding customers who have issued those books.
SELECT i.Issued_book_name, c.Customer_name 
FROM IssueStatus i JOIN Customer c ON i.Issued_cust = c.Customer_ID;

-- 4) Display the total count of books in each category. 
select count(*) as book_count , category  from books group by category ;

-- 5)Retrieve the employee names and their positions for the employees whose salaries are above Rs.25,000.
select emp_name,position from employee where salary>'25000';

-- 6)List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' 
AND Customer_ID NOT IN (
		SELECT Issued_cust FROM IssueStatus 
	);
    
-- 7) Display the branch numbers and the total count of employees in each branch.
SELECT branch.branch_no, COUNT(employee.emp_id) AS total_employees
FROM branch
LEFT JOIN employee ON branch.manager_id = employee.emp_id
GROUP BY branch.branch_no;

-- 8) Display the names of customers who have issued books in the month of June 2023.
select c.customer_name from customer c inner join issuestatus i on c.customer_id = i.Issued_cust  where month(i.Issue_date)='10';

-- 9) Retrieve book_title from book table containing fairytale.
select book_title from books where Category = 'fairytale';

-- 10)Retrieve the branch numbers along with the count of employees for branches having more than 0 employees
SELECT branch.branch_no, COUNT(employee.emp_id) AS total_employees
FROM branch
LEFT JOIN employee ON branch.manager_id = employee.emp_id
GROUP BY branch.branch_no having total_employees >0;
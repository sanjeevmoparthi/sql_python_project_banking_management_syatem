### capstone project - banking management system

create database banking_management_system; 
use banking_management_system;

create table User_personal_data(
customer_id int primary key,
name varchar(20) not null,
contact varchar(10) unique,
city varchar(15)

);

create table User_banking_data(
customer_id int  ,
acc_no int  primary key,
acc_balance int not null,
acc_type varchar (10)  default 'Saving ',
branch_code varchar(10),
foreign key (customer_id) references User_personal_data(customer_id)

);

create table User_private_data(
acc_no int ,
atm_card_no  int  primary key,
atm_pin int not null ,
foreign key (acc_no) references User_banking_data(acc_no)
);


create table User_private_data(
acc_no int ,
atm_card_no  int  primary key,
atm_pin int not null ,
foreign key (acc_no) references User_banking_data(acc_no)
);


create table user_transcation_data(
acc_no int,
tranx_id varchar(15) primary key,
amount decimal(10,2) not null,
update_acc_balance int not null,
tranx_type varchar (10) default 'Neft',
tranx_date date not null,
foreign key (acc_no) references user_banking_data(acc_no)
);


create table User_internet_banking_data(
acc_no int ,
user_name   varchar(15) primary key,
pass varchar(20)  not null ,
foreign key (acc_no) references User_banking_data(acc_no)
);

create table User_deleted_data(
acc_no int  primary key ,
name varchar(20),
last_balance decimal (10,2) default 0 ,
contact varchar(10),
branch_code varchar (10)

);

#triggers


use banking_management_system ;
-- delimiter $$
-- create trigger update_acc_balance
-- after insert on user_transcation_data
-- for each row
-- begin 
-- 	update user_banking_data
--     set acc_balance = new.update_acc_balance
--     where acc_no = new.acc_no ;
-- end $$
-- delimiter $$


delimiter $$
create trigger update_deleted_data
before  delete on user_personal_data
for each row
begin 
	declare accno int ;
    declare last_bal decimal(10,2);
    declare branchcode varchar(10);
    
    select acc_no,acc_balance,branch_code into accno,last_bal,branchcode
    from user_banking_data
    where customer_id = old.customer_id;
    
    
    insert into user_deleted_data values(accno,old.name,last_bal,old.contact,branchcode);
    
    delete from user_banking_data where customer_id = old.customer_id;
    delete from user_intenet_banking_data where acc_no = accno;
    delete from user_private_data where acc_no = accno ;
    
    
    
	
end $$
delimiter $$

insert into user_personal_data values (1234,'Ayush',34342323,'Mumbai');
insert into user_personal_data values (1235,'Ankit',98342323,'Delhi');

insert into user_banking_data values (1234,456789,200,'saving','mum2');
insert into user_banking_data values (1235,456781,0,'current','del1');

insert into user_transcation_data values (456789,232231,100,100,'UPI',current_date());
insert into user_transcation_data values (456781,323232,500,500,'NEFT',current_date()); 



 drop trigger update_deleted_data;

delimiter $$
create trigger update_deleted_data
before  delete on user_transcation_data
for each row
begin 
	declare fullname varchar(20) ;
    declare last_bal decimal(10,2);
    declare branchcode varchar(10);
    declare cont varchar(10);
    declare cust int;
    
    select customer_id,acc_balance,branch_code into cust,last_bal,branchcode
    from user_banking_data
    where acc_no = old.acc_no;
    
    select name,contact into fullname,cont
    from user_personal_data 
    where customer_id = cust;
    
    
    insert into user_deleted_data values(old.acc_no,fullname,last_bal,cont,branchcode);
     
	-- delete from user_internet_banking_data where acc_no = old.acc_no;
    delete from user_private_data where acc_no = old.acc_no ;
    delete from user_banking_data where customer_id = cust;
    delete from user_personal_data where customer_id = cust;
    
    
    
    
	
end $$
delimiter $$

delete from user_transcation_data where acc_no = 456789;

CREATE DEFINER=`root`@`localhost` FUNCTION `check_balance`() RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
	declare av_bal decimal(10,2);
    select acc_balance into av_bal
    from user_banking_data
    where acc_no = acc_no;

RETURN avl_bal;
END

USE `sys`;
DROP procedure IF EXISTS `create_last_5_tranx`;

DELIMITER $$
USE `sys`$$
CREATE PROCEDURE `create_last_5_tranx` ()
BEGIN
	select * from user_transcation_data
    where acc_no = acc_n
    order by tranx_data desc
    limit 5 ;

END$$

DELIMITER $$ 


























































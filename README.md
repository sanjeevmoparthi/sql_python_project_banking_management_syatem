Capstone Project: Banking Management System 

Project Overview :

In this project, you'll design and implement a MySQL-based Banking Management System. The 
system will consist of five interconnected tables that manage different aspects of customer and 
transac on data. You will also create triggers, func ons, and procedures to enforce business rules 
and automate tasks within the system. 
Tables Design 
1. User Personal Data 
o Fields: customer_id, name, date_of_birth, address, email, phone_number 
o Primary Key: customer_id 
o Descrip on: Stores personal informa on about the customers. 
2. User Banking Data 
o Fields: customer_id, account_number, account_balance, account_type, branch_code 
o Primary Key: account_number 
o Foreign Key: customer_id references User Personal Data(customer_id) 
o Descrip on: Manages banking details for each customer, including their balance and 
account type. 
3. User Private Informa on 
o Fields: account_number, atm_card_number, atm_pin, security_ques on, 
security_answer 
o Primary Key: atm_card_number 
o Foreign Key: account_number references User Banking Data(account_number) 
o Descrip on: Stores confiden al informa on such as ATM card numbers and PINs. 
4. Transac on Detail 
o Fields: transac on_id, account_number, transac on_date, transac on_amount, 
transac on_type, balance_a er_transac on 
o Primary Key: transac on_id 
o Foreign Key: account_number references User Banking Data(account_number) 
o Descrip on: Tracks all transac ons made by the customers, including deposits and 
withdrawals. 
5. Internet Banking Details 
o Fields: account_number, username, password, last_login, login_a empts 
o Primary Key: Username 
o Foreign Key: account_number references User Banking Data(account_number) 
o Descrip on: Manages Internet banking creden als and ac vi es for each customer. 
6. Recycle bin 
o Important columns from the above table 
Trigger: Update_Balance_A er_Transac on 
Purpose: The Update_Balance_A er_Transac on trigger is designed to automa cally update the 
account balance in the User_Banking_Data table whenever a new transac on (such as a deposit or 
withdrawal) is recorded in the Transac on_Detail table. This ensures that the account balance 
remains accurate and consistent without requiring manual updates. 
Trigger: Update_recycle_bin 
Purpose: The Update_recycle_bin trigger is designed to transfer the deleted data into recycle bin 
table 

FUNCTION: Check_Available_Balance: This func on defines a check_available_balance func on that 
takes an account number as input and returns the available balance as a decimal value. 
FUNCTION: Check_Last_5_Transac ons: Defines a func on named Check_Last_5_Transac ons that 
takes an account number as input and returns a table of the last 5 transac ons. 

Procedure: Withdraw_Funds : 
The Withdraw_Funds stored procedure is designed to handle the withdrawal of funds from a 
specified account in a banking management system. It performs the necessary checks to ensure that 
the account has sufficient funds before processing the withdrawal and updates the transac on 
history accordingly. 

Procedure: Deposit_Funds : 
The Deposit_Funds stored procedure automates the process of deposi ng funds into an account. It 
accurately updates the account balance and records the transac on, ensuring consistency and 
transparency in the banking system. This procedure is essen al for maintaining up-to-date financial 
records and providing a clear audit trail for all deposits. 
Write basic Front end in Python to perform these opera ons by taking input from the user: 
1. New user registra on 
2. Deposit money 
3. Withdraw money 
4. Check Balance 
5. Check the last 5 transac on 
6. Delete the Bank account
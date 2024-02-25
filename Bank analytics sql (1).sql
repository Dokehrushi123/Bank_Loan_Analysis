select * from finance_1;
select * from finance_2;



#-------KPI 1 .....Year wise loan amount Stats

create view Year_wise_loan as 
select year(issue_d2) as Yer, concat(sum(loan_amnt)/1000,"K") as loanAmt from finance_1
group by 1
order by yer asc;

select * from Year_wise_loan;

#---------KPI 2 ---------Grade and sub grade wise revol_bal

select f1.grade , f1.sub_grade ,concat(sum(f2.revol_bal)/1000,"K") as Revol_Bal from finance_1 as f1
join finance_2 as f2
on f1.id = f2.id
group by 1,2
order by 1;

#--------KPI 3----------Total Payment for Verified Status Vs Total Payment for Non Verified Status


create view Verification_status as 
select f1.verification_status , concat(format(round(sum(f2.total_pymnt/1000000),2),2),"M") from finance_1 as f1
join finance_2 as f2 on
f1.id= f2.id
group by 1
limit 2;

select * from Verification_status;



#-------------KPI 4----------State wise and month wise loan status



select 
addr_state as state,monthname(issue_d2) as "Month",
sum(case when loan_status = "Fully Paid" then 1 else 0 end) as "Fully Paid",
sum(case when loan_status="Charged Off" then 1 else 0 end) as "Charged odd",
sum(case when loan_status="Current" then 1 else 0 end) as "Current",
count(*) as "Total count"
from finance_1 
group by addr_state,monthname(issue_d2)
order by addr_state , monthname(issue_d2) desc;



#-----------KPI 5 --------Home ownership Vs last payment date stats



select f1.home_ownership as Ownership, f2.last_pymnt_d as "Date",concat(format(sum(f2.last_pymnt_amnt)/1000,2),"K") as Amount
from finance_1 as f1
join finance_2 as f2 on
f1.id=f2.id
where f2.last_pymnt_d <> ""
group by 1 , 2
order by 1,2 desc;





#-----------------------------------END OF KPI'S---------------------------





/*1.To gain a comprehensive understanding of the factors influencing hospitalization costs, it is necessary to combine the tables provided. Merge the two tables by first identifying the
columns in the data tables that will help you in merging.
a. In both tables, add a Primary Key constraint for these columns
Hint:You can remove duplicates and null values from the column and then use ALTER TABLE to add a Primary Key constraint.*/
create database healthcare ;
use healthcare;
select * from hospitalisation_details;
select * from medical_examinations ;

-- Lets Deal with the null value.
SET SQL_SAFE_UPDATES = 0;
delete from hospitalisation_details where `Customer ID`='?';
delete from hospitalisation_details where `State ID`='?';
delete from hospitalisation_details where `City tier`='?';

-- Now lets assign the primary key to the column in the table.
ALTER TABLE healthcare.hospitalisation_details 
CHANGE COLUMN `Customer ID` `Customer ID` varchar(20),
ADD PRIMARY KEY (`Customer ID`);

ALTER TABLE healthcare.medical_examinations
CHANGE COLUMN `Customer ID` `Customer ID` varchar(20),
ADD PRIMARY KEY (`Customer ID`);

-- Now lets merge the both table for better understanding of hospitalisation cost.
select * from hospitalisation_details  h
inner join medical_examinations m
on h.`Customer ID`= m.`Customer ID`;

/* Question No:-2. Retrieve information about people who are diabetic and have heart problems with their average age,
 the average number of dependent children, average BMI, and average hospitalization costs */
 
 select m.HBA1C , m.`Heart Issues` , avg(h.children) , avg(m.BMI) , avg(h.charges)
 from healthcare.hospitalisation_details h
 inner join healthcare.medical_examinations m
 on h.`Customer ID` = m.`Customer ID`
 where m.HBA1C > 6.5 and m.`Heart Issues` = 'yes';
 
 /* Question NO.3:- Find the average hospitalization cost for each hospital tier and each city level.*/  
 select `Hospital tier` , `City tier`, avg(charges) as Hospitalization_Cost
 from healthcare.hospitalisation_details
 group by `Hospital tier` , `City tier`;
 
 /* Question No4:- Determine the number of people who have had major surgery with a history of cancer. */
select count(NumberOfMajorSurgeries) as major_surgery_count
from healthcare.medical_examinations
where `Cancer history` = 'Yes';

/* Question No5:- Determine the number of tier-1 hospitals in each state. */
select `State ID`,count(`Hospital tier`) as No_Tier1_Hos
from healthcare.hospitalisation_details
where `Hospital tier` = 'tier - 1'
group by `State ID`;
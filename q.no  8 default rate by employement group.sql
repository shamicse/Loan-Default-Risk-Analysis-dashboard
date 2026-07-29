use riskmanagement;

-- what is overall default rate?

select
count(*) as total_loan,
sum(defaulted) as total_default,
round(sum(defaulted)/count(*)*100,2) as default_percent
from loan_applications;

-- how does it break down by credit score range e.g (520-599, 600-649 ,650-699, 700-749, 750+)

select
case
when bp.credit_score between 520 and 599 then '520-599'
when bp.credit_score between 600 and 649 then '600-649'
when bp.credit_score between 650 and 699 then '650-699'
when bp.credit_score between 700 and 749 then '700-749'
when bp.credit_score between 750 and 799 then '750-799'
when bp.credit_score between 800 and 849 then '880-849'
when bp.credit_score  >= 850 then '850+'
else 'below 520'
end as credit_score_bucket,
count(*) as total_loan,
sum(defaulted) as total_default,
round(sum(defaulted)/count(*)*100,2) as default_percent
from loan_applications la
join borrower_profiles bp on la.borrower_id = bp.borrower_id
group by credit_score_bucket
order by credit_score_bucket;

-- is there a relationship between a borrower's debt-to-income (dti) ratio and the likelihood of the defaulting

select 
case 
when dti_ratio < 20 then '0-19'
when dti_ratio < 20 and 29 then '20-29'
when dti_ratio < 30 and 39 then '30-39'
when dti_ratio < 40 and 49 then '40-49'
else '50+'
end as dti_ratio_bucket,
count(*) as total_loan,
sum(defaulted) as total_default,
round(sum(defaulted)/count(*)*100,2) as default_percent
from loan_applications
group by dti_ratio_bucket
order by dti_ratio_bucket;


-- which loan purposes have the highest default rate

select 
loan_purpose,
count(*) as total_loan,
sum(defaulted) as total_default,
round(sum(defaulted)/count(*)*100,2) as default_percent
from loan_applications
group by loan_purpose
order by default_percent desc;

-- does the average loan amount differ significantly between defaulted and non-defaulted loans

select 
defaulted,
count(*) as total_loans,
round(avg(loan_amount),0) as avg_loan_amount,
min(loan_amount) as min_loan,
max(loan_amount) as max_loan
from loan_applications
group by defaulted;

-- how do employment status effect default risk?

select
bp.employment_status,
count(*) as total_loan,
sum(la.defaulted) as total_default,
round(sum(la.defaulted)/count(*)*100,2) as default_percent
from loan_applications la
join borrower_profiles bp on la.borrower_id = bp.borrower_id
group by employment_status
order by default_percent desc;

-- how do years employed affect default risk?

select
case 
when bp.years_employed < 2 then '<2 years'
when bp.years_employed between 2 and 5 then '2-5 years'
when bp.years_employed between 6 and 10 then '6-10 years'
else '10+ years'
end as employment_tenure,
count(*) as total_loans,
sum(la.defaulted) as total_defaults,
round(sum(la.defaulted)/count(*)*100,2) as default_percent
from loan_applications la
join borrower_profiles bp on la.borrower_id = bp.borrower_id
group by employment_tenure
order by
case employment_tenure
when '<2 years' then 1
when '2-5 years' then 2
when '6-10 years' then 3
when '10+ years' then 4
else 5
end asc;

-- are borrowers with less than 2 years of employment more likely to default?

select
case
when bp.years_employed < 2 then '<2 years'
else '2+ years'
end as employment_group,
count(*) as total_loans,
sum(la.defaulted) as total_defaults,
round(sum(la.defaulted)/count(*)*100,2) as default_percent
from loan_applications la
join borrower_profiles bp on la.borrower_id = bp.borrower_id
group by employment_group
order by employment_group;

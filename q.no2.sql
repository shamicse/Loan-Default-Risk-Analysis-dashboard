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
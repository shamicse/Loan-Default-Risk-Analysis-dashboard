use riskmanagement;

-- what is overall default rate?

select
count(*) as total_loan,
sum(defaulted) as total_default,
round(sum(defaulted)/count(*)*100,2) as default_percent
from loan_applications;
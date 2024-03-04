with recursive recu_cte as (select int_numbers, 1 as counter 
from tbl_numbers
union all
select int_numbers, counter+1 from recu_cte where int_numbers>
counter)
select int_numbers as seq_numbers from recu_cte
 order by seq_numbers;
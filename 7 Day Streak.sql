with each_day_event as (
select distinct user_id, date(created_at) as create_date, url  
from events)
, lagged_date as (
select user_id, url,create_date, date_sub(create_date , INTERVAL
rank() over(partition by user_id order by  create_date )day
) as grp from each_day_event) ,
streaked as (
select user_id, url, grp, count(*) as streak from lagged_date group 
by user_id, url, grp having streak >6)
select count(stre.user_id)/count(nor.user_id) percent_of_users   from each_day_event nor left join
 streaked stre on stre.user_id = nor.user_id
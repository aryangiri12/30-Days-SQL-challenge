--LinkedIn is a professional social networking app.
--They want to give top voice badge to their best creators to encourage them to create more quality content.
--A creator qualifies for the badge if he/she satisfies following criteria. 
--1- Creator should have more then 50k followers.
--2- Creator should have more than 100k impressions on the posts that they published in the month of Dec-2023.
--3- Creator should have published atleast 3 posts in Dec-2023.
--Write a SQL to get the list of top voice creators name along with no of posts and impressions by them in the month of Dec-2023.
SELECT * FROM creators ;
SELECT * FROM posts ;

select   c.creator_name ,
sum(p.impressions) as total_impressions,
count(p.post_id) as tno_of_posts
from creators c
join posts p
 ON c.creator_id = p.creator_id
 where  publish_date>= '2023-12-01' and
 publish_date < '2024-01-01'
 group by c.creator_name
 having sum(p.impressions)>= 100000 and
 count(p.post_id)>=3 and
 max(c.followers) >50000 ; -- here i'm using max becouse we havent included followes in the group by ,so we can't use followers >500000 

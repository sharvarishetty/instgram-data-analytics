/*  Identify the five oldest users on Instagram from the provided database.*/
USE ig_clone;
SELECT id, username, created_at
FROM users
ORDER BY created_at ASC
LIMIT 5;
SELECT u.id, u.username
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
WHERE p.id IS NULL;
/* Identify users who have never posted a single photo on Instagram.*/
 
 SELECT p.id AS photo_id, u.username, COUNT(l.user_id) AS total_likes
FROM photos p
JOIN likes l ON p.id = l.photo_id
JOIN users u ON p.user_id = u.id
GROUP BY p.id, u.username
ORDER BY total_likes DESC
LIMIT 1;
/* Determine the winner of the contest and provide their details to the team.*/
SELECT t.tag_name, COUNT(pt.photo_id) AS usage_count
FROM tags t
JOIN photo_tags pt ON t.id = pt.tag_id
GROUP BY t.tag_name
ORDER BY usage_count DESC
LIMIT 5;
/* 5)  Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.*/
SELECT DAYNAME(created_at) AS day_of_week, COUNT(id) AS registrations
FROM users
GROUP BY day_of_week
ORDER BY registrations DESC
LIMIT 1;
/* insight:
Given that Thursday is the peak registration day, it is recommended to launch or heavily focus your ad campaigns on Thursdays. 
You can also consider extending the campaign from Wednesday to Friday to maximize engagement. 
This strategic timing aligns with the period when users are most active on the platform, 
thereby increasing the chances of interaction with your ads and driving better campaign performance.*/

/* 
Calculate the average number of posts per user.
a) Average posts per user:
*/
SELECT AVG(post_count) AS avg_posts_per_user
FROM (
    SELECT u.id, COUNT(p.id) AS post_count
    FROM users u
    LEFT JOIN photos p ON u.id = p.user_id
    GROUP BY u.id
) AS user_post_counts;
/*This subquery counts the number of posts per user, and the outer query calculates the average.*/

/*Total number of photos divided by total number of users:*/
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg_photos_per_user;
/*query directly divides the total number of photos by the total number of users.*/

/*Identify users who have liked every single photo on the platform.*/
SELECT u.id, u.username
FROM users u
JOIN likes l ON u.id = l.user_id
GROUP BY u.id
HAVING COUNT(l.photo_id) = (SELECT COUNT(*) FROM photos);



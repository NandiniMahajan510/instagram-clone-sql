-- REWARDS FOR THE USERS WHO USED INSTAGRAM FRO MORE THAN 5 YEARS
SELECT *
FROM USERS
ORDER BY created_at
LIMIT 5;
-- To find in which day of the week maximum number of users register
SELECT DAYNAME(created_at) AS 'day',
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER by total DESC
LIMIT 2;
-- To send email to the users who havenot posted yet
SELECT username,
    image_url
FROM users
    LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;
-- To run a contest who gets the maximum number of likes on a single photo
SELECT username,
    photos.id,
    photos.image_url,
    COUNT(*) AS total
FROM photos
    INNER JOIN likes ON likes.photo_id = photos.id
    INNER JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;
-- -- HOW many times does average user post
SELECT (
        SELECT COUNT(*)
        FROM photos
    ) /(
        SELECT COUNT(*)
        FROM users
    ) AS average;
-- -- find users who have liked every single photo on site
--  SELECT COUNT(*) FROM photos;
SELECT username,
    user_id,
    COUNT(*) AS total
FROM users
    INNER JOIN likes ON users.id = likes.user_idGROUP BY likes.user_id
HAVING total = (
        SELECT COUNT(*)
        FROM photos
    );
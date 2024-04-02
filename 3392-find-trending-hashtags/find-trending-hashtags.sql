# Write your MySQL query statement below
SELECT REGEXP_SUBSTR(tweet, '#[A-Za-z]+') AS hashtag
    , COUNT(*) AS hashtag_count
FROM Tweets
GROUP BY REGEXP_SUBSTR(tweet, '#[A-Za-z]+')
ORDER BY COUNT(*) DESC, hashtag DESC
LIMIT 3

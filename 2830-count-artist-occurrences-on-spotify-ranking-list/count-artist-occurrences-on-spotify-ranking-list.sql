# Write your MySQL query statement below
SELECT artist, COUNT(*) AS occurrences
FROM Spotify
GROUP BY artist
ORDER BY occurrences DESC, artist
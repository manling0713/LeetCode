# Write your MySQL query statement below
SELECT CASE WHEN A = B AND B = C THEN 'Equilateral' 
    WHEN (A=B AND B<>C AND A+B>C) OR (A=C AND A<>B AND A+C>B) OR (B=C AND A<>B AND B+C>A) THEN 'Isosceles' 
    WHEN ((A+B)<=C) OR ((A+C)<=B) OR ((B+C)<=A) THEN 'Not A Triangle' 
    ELSE 'Scalene' END AS triangle_type
FROM Triangles
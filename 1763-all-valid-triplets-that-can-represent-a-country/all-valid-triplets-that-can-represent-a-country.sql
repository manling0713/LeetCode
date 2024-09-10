# Write your MySQL query statement below
SELECT a.student_name AS member_A
    , b.student_name AS member_B
    , c.student_name AS member_C
FROM SchoolA a, SchoolB b, SchoolC c
WHERE a.student_name <> b.student_name 
    AND c.student_name <> b.student_name 
    AND a.student_name <> c.student_name
    AND a.student_id <> b.student_id 
    AND c.student_id <> b.student_id
    AND a.student_id <> c.student_id
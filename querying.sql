-- All record including name, branch and score of the student greater then average score
SELECT s.name, s.branch ,e.score 
FROM exam_scores as e 
INNER JOIN students as s ON s.student_id = e.student_id
WHERE e.score > (
    SELECT AVG(score)
    FROM exam_scores 
)


SELECT s.name,
    s.student_id,
    s.branch
FROM students as s
WHERE s.student_id IN (
        SELECT student_id
        FROM exam_scores
        WHERE score >= 90
    )
    AND s.student_id IN (
        SELECT student_id
        FROM projects
        WHERE marks >= 85
    )


SELECT student_id, SUM(score) , COUNT(*) as attempts
FROM exam_scores as e
GROUP BY student_id
SELECT total_stats.student_id , s.name, s.branch , total_stats.attempts
FROM (
    SELECT student_id, SUM(score) , COUNT(*) as attempts
FROM exam_scores as e
GROUP BY student_id
) as total_stats
INNER JOIN students as s 
    ON s.student_id =  total_stats.student_id

    
-- for each project get student's name , branch, project marks
-- and their average exam score on the same row
SELECT s.student_id,
    s.name,
    s.branch,
    p.title,
    p.marks,
    exam_avg.averge_score
FROM projects as p
    INNER JOIN students as s ON p.student_id = s.student_id
    INNER JOIN (
        SELECT student_id,
            AVG(score) as averge_score
        FROM exam_scores
        GROUP BY student_id
    ) as exam_avg ON exam_avg.student_id = p.student_id
    
    
-- there is a need of a report where we have list of exam attempts
--  which are above average (score> average class score)
-- Also include name of the students in report


-- First of all we are creating the report table to make report 

CREATE TABLE higest_score_report(
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    student_name VARCHAR(50) NOT NULL,
    subject VARCHAR(30) NOT NULL,
    score INT NOT NULL,
    archived_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
)

-- inserting the data into the table
INSERT INTO higest_score_report(
    student_id,
    student_name,
    subject,
    score
)
SELECT s.student_id ,s.name,e.subject, e.score
FROM exam_scores as e
INNER JOIN students as s ON s.student_id = e.student_id
WHERE e.score > (
    SELECT AVG(score) FROM exam_scores
)

-- fetching data from the database
SELECT * FROM higest_score_report
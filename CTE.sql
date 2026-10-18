WITH averagescore AS (
    SELECT AVG(score) as avgscore
    FROM exam_scores
)
SELECT s.name as studentname,
    s.branch as student_branch,
    e.score,
    Avgs.avgscore
FROM exam_scores as e
    INNER JOIN students as s ON s.student_id = e.student_id
    CROSS JOIN averagescore as Avgs
WHERE e.score > Avgs.avgscore




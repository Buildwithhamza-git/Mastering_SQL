-- All record including name, branch and score of the student greater then average score

-- SELECT s.name, s.branch ,e.score 
-- FROM exam_scores as e 
-- INNER JOIN students as s ON s.student_id = e.student_id
-- WHERE e.score > (
--     SELECT AVG(score)
--     FROM exam_scores 
-- )
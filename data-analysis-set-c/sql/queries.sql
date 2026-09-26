-- =====================================================================
-- Data Analysis Set C - Training Performance : queries.sql
-- SQL dialect : SQLite 3   (run AFTER setup.sql)
-- =====================================================================

-- ---------- S2a: Average score by department (lowest first) ----------
SELECT  c.department,
        ROUND(AVG(a.score), 2) AS avg_score
FROM    assessments a
JOIN    courses c ON c.course_id = a.course_id
GROUP BY c.department
ORDER BY avg_score ASC, c.department ASC;

-- ---------- S2b: Underperforming courses (average score below 60) ----------
SELECT  c.course_id,
        c.course,
        ROUND(AVG(a.score), 2) AS avg_score
FROM    assessments a
JOIN    courses c ON c.course_id = a.course_id
GROUP BY c.course_id, c.course
HAVING  AVG(a.score) < 60
ORDER BY avg_score ASC, c.course_id;

-- ---------- S2c: Top two batches by average score ----------
-- ties broken by alphabetical batch name
SELECT  batch,
        ROUND(AVG(score), 2) AS avg_score
FROM    assessments
GROUP BY batch
ORDER BY AVG(score) DESC, batch ASC
LIMIT 2;

-- ---------- S3: Integrity check (LEFT JOIN courses -> assessments) ----------
-- Part 1: rows matched per course (every course should have matches)
SELECT  c.course_id,
        COUNT(a.assessment_id) AS matched_assessment_rows
FROM    courses c
LEFT JOIN assessments a ON a.course_id = c.course_id
GROUP BY c.course_id
ORDER BY c.course_id;

-- Part 2: fact-table keys with no lookup row (expected result: 0)
SELECT  COUNT(*) AS unmatched_keys
FROM    assessments a
LEFT JOIN courses c ON c.course_id = a.course_id
WHERE   c.course_id IS NULL;

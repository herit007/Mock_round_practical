-- =====================================================================
-- Data Analysis Set C - Training Performance : setup.sql
-- SQL dialect : SQLite 3 (tested with SQLite 3.45.1)
-- Run order   : 1) setup.sql   2) queries.sql
-- Loads exactly 4 lookup rows and 12 UNIQUE fact rows
-- (the duplicate assessment_id 12 row of the raw CSV is excluded).
-- =====================================================================
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS assessments;
DROP TABLE IF EXISTS courses;

CREATE TABLE courses (
    course_id  TEXT PRIMARY KEY,
    course     TEXT NOT NULL,
    department TEXT NOT NULL
);

CREATE TABLE assessments (
    assessment_id  INTEGER PRIMARY KEY,
    month          TEXT NOT NULL CHECK (month IN ('Jan','Feb','Mar')),
    course_id      TEXT NOT NULL,
    batch          TEXT NOT NULL,
    score          REAL NOT NULL CHECK (score BETWEEN 0 AND 100),
    attendance_pct REAL NOT NULL CHECK (attendance_pct BETWEEN 0 AND 100),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

INSERT INTO courses (course_id, course, department) VALUES
    ('C1', 'Excel',   'Business'),
    ('C2', 'PowerBI', 'Business'),
    ('C3', 'SQL',     'Technology'),
    ('C4', 'Python',  'Technology');

-- 12 unique rows (raw file has 13 rows; duplicate of assessment_id 12 removed)
INSERT INTO assessments (assessment_id, month, course_id, batch, score, attendance_pct) VALUES
    (1,  'Jan', 'C1', 'Morning', 72, 90),
    (2,  'Jan', 'C2', 'Evening', 45, 70),
    (3,  'Jan', 'C3', 'Morning', 65, 85),
    (4,  'Jan', 'C4', 'Weekend', 38, 60),
    (5,  'Feb', 'C1', 'Evening', 80, 95),
    (6,  'Feb', 'C2', 'Weekend', 55, 80),
    (7,  'Feb', 'C3', 'Morning', 48, 75),
    (8,  'Feb', 'C4', 'Evening', 68, 88),
    (9,  'Mar', 'C1', 'Weekend', 90, 98),
    (10, 'Mar', 'C2', 'Morning', 60, 82),
    (11, 'Mar', 'C3', 'Evening', 75, 92),
    (12, 'Mar', 'C4', 'Weekend', 42, 65);

-- Row-count verification (expected: courses = 4, assessments = 12)
SELECT 'courses' AS table_name, COUNT(*) AS row_count FROM courses
UNION ALL
SELECT 'assessments', COUNT(*) FROM assessments;

# Video script (target 7-8 min, face + screen together)
1. (0:30) Name, student ID, Set C, business question: which course needs most academic support, and how do batches differ?
2. (1:00) Dataset: 13 rows, 1 exact duplicate (assessment_id 12) removed -> 12; courses lookup 4 rows; pass_flag = score >= 50.
3. (1:30) Excel: Raw vs Clean (13 -> 12), INDEX/MATCH department, IF pass_flag, COUNTIFS by batch, PivotTable + chart.
4. (1:15) SQL: run setup.sql then S2a live; explain JOIN + AVG + ORDER BY; show LEFT JOIN check = 0 unmatched.
5. (1:15) Python: run `python python/analysis.py`, show merge assertion, pass_flag line, lowest pass-rate course (1/3), chart.
6. (1:30) Power BI: show Pass Rate DAX, click Weekend slicer (4 / 56.25 / 50.00%), clear it.
7. (1:00) Findings: Technology 56.00 vs Business 67.00; Python 1/3 = 33.33%; recommendation; limitation; repo structure.

# Power BI build guide (about 25 minutes) -> saves as `powerbi/dashboard.pbix`
`.pbix` files can only be created in Power BI Desktop (Windows). Follow these steps.

## 1. Parameter + queries (B1, 1 mark)
1. Power BI Desktop > **Transform data**.
2. **Manage Parameters > New Parameter**: Name `DataFolder`, Type *Text*, value = full path of `data\raw\` **ending with a backslash**, e.g. `C:\Users\YOU\data-analysis-set-c-XXXX\data\raw\`.
3. **New Source > Blank Query** > Advanced Editor > paste `power_query_assessments.m` > name it `assessments`.
4. Repeat with `power_query_courses.m` > name it `courses`.
5. Check types (assessment_id = Whole number; score, attendance_pct = Decimal/Whole number; others Text). Status bar must show **12 rows** for assessments. **Close & Apply**.

## 2. Model (B1, 1 mark)
- Model view: drag `courses[course_id]` onto `assessments[course_id]`.
- Cardinality **One to many (1:\*)**, Cross-filter direction **Single**, **Active** ticked.
- Select `assessments[month]` > Column tools > **Sort by column** > `month_no`.

## 3. DAX (B2, 3 marks)
Home > Enter Data > empty table `Measures` > Load. Add the 3 measures from `measures.dax`.

## 4. Report page (B3, 2 marks)
| Visual | Fields |
|---|---|
| Card 1 | Assessment Count |
| Card 2 | Avg Score |
| Card 3 | Pass Rate (format %) |
| Clustered bar chart | Axis = `courses[department]`, Values = Avg Score |
| Column/line chart | Axis = `assessments[month]` (Jan, Feb, Mar), Values = Avg Score |
| Slicer | `assessments[batch]` |
Title the page **Training Performance - Set C**, add data labels and axis titles.

## 5. Values you should see (verify)
| State | Assessment Count | Avg Score | Pass Rate |
|---|---|---|---|
| Unfiltered | 12 | 61.50 | 66.67% |
| Batch = Morning | 4 | 61.25 | 75.00% |
| Batch = Evening | 4 | 67.00 | 75.00% |
| Batch = Weekend | 4 | 56.25 | 50.00% |
| Technology (card filtered) | 6 | 56.00 | 50.00% |
Department bar (Avg Score): Business 67.00, Technology 56.00. Monthly: Jan 55.00, Feb 62.75, Mar 66.75.

## 6. Screenshot + save
Clear the slicer, screenshot the page -> `outputs/powerbi_dashboard.png`. File > Save as `powerbi/dashboard.pbix`.

## 7. Refresh after cloning
Home > Transform data > **Edit parameters** > change `DataFolder` to the new `data\raw\` path > OK > **Refresh**.

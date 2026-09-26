// ===== Query: assessments (Transform data > New Source > Blank Query > Advanced Editor) =====
// Needs a text parameter named DataFolder, e.g. C:\Users\YOU\data-analysis-set-c-YOUR-STUDENT-ID\data\raw\
let
    Source   = Csv.Document(File.Contents(DataFolder & "assessments.csv"),
                 [Delimiter=",", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Typed    = Table.TransformColumnTypes(Promoted, {
                 {"assessment_id", Int64.Type}, {"month", type text}, {"course_id", type text},
                 {"batch", type text}, {"score", type number}, {"attendance_pct", type number}}),
    // remove the exact duplicate row -> 13 rows become 12
    Dedup    = Table.Distinct(Typed),
    // helper column so month sorts Jan -> Feb -> Mar
    AddMonthNo = Table.AddColumn(Dedup, "month_no",
                 each if [month] = "Jan" then 1 else if [month] = "Feb" then 2 else 3, Int64.Type)
in
    AddMonthNo

// ===== Query: courses =====
let
    Source   = Csv.Document(File.Contents(DataFolder & "courses.csv"),
                 [Delimiter=",", Columns=3, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Typed    = Table.TransformColumnTypes(Promoted,
                 {{"course_id", type text}, {"course", type text}, {"department", type text}})
in
    Typed

; extends

(assignment
  left: (identifier) @_id (#match? @_id "sql")
  right: (string (string_content) @sql (#offset! @sql 0 0 0 0))
) @sql_explicit

(assignment
  left: (identifier)
  right: (string (string_content) @sql (#match? @sql "SELECT|INSERT|WITH|CREATE"))
) @sql_implicit

json.array!(@timetable_time_tables) do |timetable_time_table|
  json.extract! timetable_time_table, :id, :course_id, :start_date, :comments
  json.url timetable_time_table_url(timetable_time_table, format: :json)
end

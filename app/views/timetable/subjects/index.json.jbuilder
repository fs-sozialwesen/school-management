json.array!(@timetable_subjects) do |timetable_subject|
  json.extract! timetable_subject, :id, :name, :comments
  json.url timetable_subject_url(timetable_subject, format: :json)
end

json.array!(@timetable_time_blocks) do |timetable_time_block|
  json.extract! timetable_time_block, :id, :start_time, :end_time
  json.url timetable_time_block_url(timetable_time_block, format: :json)
end

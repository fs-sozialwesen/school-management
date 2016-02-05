json.array!(@timetable_rooms) do |timetable_room|
  json.extract! timetable_room, :id, :name, :comments
  json.url timetable_room_url(timetable_room, format: :json)
end

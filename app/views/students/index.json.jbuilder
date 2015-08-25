json.array!(@students) do |student|
  json.extract! student, :id, :first_name, :last_name, :address, :email, :phone, :date_of_birth, :place_of_birth, :comments
  json.url student_url(student, format: :json)
end

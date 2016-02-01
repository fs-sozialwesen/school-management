json.array!(@managers) do |manager|
  json.extract! manager, :id, :person_id
  json.url manager_url(manager, format: :json)
end

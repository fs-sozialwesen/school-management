json.array!(@role_candidates) do |role_candidate|
  json.extract! role_candidate, :id, :first_name, :last_name, :year, :education_subject
  json.url role_candidate_url(role_candidate, format: :json)
end

module InternshipsHelper
  def json_for_select(organisations)
    json_organisations = {}
    organisations.each do |o|
      json_organisations[o.id] = { name: o.name }

      institutions = json_organisations[o.id][:institutions] = {}
      o.institutions.each { |ip| institutions[ip.id] = ip.name }

      mentors = json_organisations[o.id][:mentors] = {}
      o.mentors.each { |mentor| mentors[mentor.id] = mentor.name }
    end
    json_organisations
  end
end

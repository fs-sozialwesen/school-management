module InternshipsHelper
  def json_for_select(organisations)
    json_organisations = {}
    organisations.each do |o|
      json_organisations[o.id] = { name: o.name }

      ips = json_organisations[o.id][:ips] = {}
      o.internship_positions.each { |ip| ips[ip.id] = ip.name }

      mentors = json_organisations[o.id][:mentors] = {}
      o.mentors.each { |mentor| mentors[mentor.id] = mentor.name }
    end
    json_organisations
  end
end

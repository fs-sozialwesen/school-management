# class CandidateOptions
class CandidateOptions < JsonSerializer
  attribute :date,                Date
  attribute :notes,               String
  attribute :education_subject,   String
  attribute :year,                Integer
  attribute :school_graduate,     Graduate
  attribute :profession_graduate, Graduate
  attribute :internship1,         CandidateInternship
  attribute :internship2,         CandidateInternship
  attribute :police_certificate,  Boolean, default: false
  # attribute :education_contract_sent,      Date
  # attribute :education_contract_received,  Date
  # attribute :internship_contract_sent,     Date
  # attribute :internship_contract_received, Date

  # def acceptable?
  #   [school_graduate?, profession_graduate?, education_graduate?,
  #    internship_proved, police_certificate, contracts_ok?].compact.all? { |v| v }
  # end

  def contracts_ok?
    [education_contract_received, internship_contract_received].all?(&:present?)
  end

  def school_graduate?
    school_graduate.proved
  end

  def profession_graduate?
    profession_graduate.graduate.blank? ? nil : profession_graduate.proved
  end

  def education_graduate?
    education_graduate.name.blank? ? nil : education_graduate.proved
  end

  def internship1?
    internship1.institution.blank? ? nil : internship1.proved
  end

  def internship2?
    internship2.institution.blank? ? nil : internship2.proved
  end
end

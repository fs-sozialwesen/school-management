# class CandidateOptions
class CandidateOptions < JsonSerializer
  attribute :approved,            Boolean, default: false
  attribute :invited,             Boolean, default: false
  attribute :accepted,            Boolean, default: false
  attribute :rejected,            Boolean, default: false
  attribute :date,                Date
  attribute :notes,               String
  attribute :education_subject,   String
  attribute :year,                Integer
  attribute :school_graduate,     Graduate
  attribute :profession_graduate, Graduate
  attribute :education_graduate,  Graduate
  attribute :attachments,         Array[Attachment]
  attribute :internship_proved,   Boolean, default: false
  attribute :police_certificate,  Boolean, default: false
  attribute :education_contract_sent,      Date
  attribute :education_contract_received,  Date
  attribute :internship_contract_sent,     Date
  attribute :internship_contract_received, Date

  def init
    self.approved = self.invited = self.accepted = self.rejected = false
  end

  def approve
    self.approved = true
  end

  def invite
    self.invited = true
  end

  def accept
    self.accepted = true
  end

  def reject
    init
    self.rejected = true
  end
  
  def acceptable?
    [school_graduate?, profession_graduate?, education_graduate?,
     internship_proved, police_certificate, contracts_ok?].compact.all? { |v| v }
  end

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
end

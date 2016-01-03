# class CandidateInternship
class CandidateInternship < JsonSerializer
  attribute :institution, String
  attribute :months,      Integer
  attribute :proved,      Boolean, default: false
end

# class Interview
class Interview < JsonSerializer
  ANSWERS = %w(open accepted rejected).freeze
  RESULTS = %w(open accepted rejected wait).freeze

  attribute :date,       Date
  attribute :comments,   String,  default: ''
  attribute :invited,    Boolean, default: false
  attribute :answer,     String,  default: 'open'
  attribute :result,     String,  default: 'open'
  attribute :reason,     String,  default: ''

  def open?
    result == 'open'
  end

  def accepted?
    result == 'accepted'
  end

  def rejected?
    result == 'rejected'
  end

end

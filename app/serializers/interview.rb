class Interview < JsonSerializer

  ANSWERS = %w(open accepted rejected).freeze
  RESULTS = %w(open accepted rejected).freeze

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

  def accept!
    self.result = 'accepted'
  end

  def reject!
    self.result = 'rejected'
  end

  def repeat!
    self.result = 'open'
    self.comments << "\n" unless comments.blank?
    self.comments << "Vergangenes KLT:\n"
    self.comments << "Datum: #{date.present? ? I18n.l(date) : ''}\n"
    self.comments << "Zeit: #{time}\n"
    self.comments << "Ort: #{place}\n"
    self.comments << "Begründung: #{reason}\n"
    self.date  = nil
    self.time = self.place = self.reason = ''
  end

end

class Interview < JsonSerializer

  RESULTS = %w(open accepted rejected).freeze

  attribute :status,     String, default: 'planned'
  attribute :date,       Date
  attribute :time,       String
  attribute :place,      String
  attribute :comments,   String, default: ''
  attribute :result,     String, default: 'open'
  attribute :reason,     String, default: ''



  # def persisted?
  #   false
  # end

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

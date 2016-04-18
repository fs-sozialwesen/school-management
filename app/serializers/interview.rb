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

  # def accept!
  #   self.result = 'accepted'
  # end
  #
  # def reject!
  #   self.result = 'rejected'
  # end
  #
  # def repeat!
  #   self.result = 'open'
  #   comments << "\n" unless comments.blank?
  #   comments << attributes_to_text
  #   self.date = nil
  #   self.reason = ''
  # end
  #
  # private
  #
  # def attributes_to_text
  #   "Vergangenes KLT:\n" \
  #     "Datum: #{date.present? ? I18n.l(date) : ''}\n" \
  #     "Eingeladen: #{invited ? 'ja' : 'nein'}\n" \
  #     "Rückmeldung: #{answer}\n" \
  #     "Begründung: #{reason}\n"
  # end
end

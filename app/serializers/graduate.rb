class Graduate < JsonSerializer
  attribute :type,       String
  attribute :name,       String
  attribute :graduate,   String
  attribute :comments,   String
  attribute :proved,     Boolean, default: false
  attribute :address,    String
  # attribute :start_date, Date
  # attribute :end_date,   Date

  def self.school_graduates
    [
      'Hauptschulabschluss',
      'Realschulabschluss',
      'Erweiterter Realschulabschluss',
      'Allgem. Hochschulreife',
      'Fachhochschulreife FOS Soziales',
      'Fachhochschulreife FOS andere Fachrichtung',
      'Fachhochschulreife FGym',
      'Fachhochschulreife Gym',
    ]
  end

  def self.school_types
    ['Realschule']
  end

  def self.profession_graduates
    [
      'Kinderpflege', #  (2)1
      'Sozialassistenz', #  (2)1
      'sozialpflegerische Berufe', #  (2)2: [Textfeld]
      'Fremdberuf', #  (2)3: [Textfeld]
      'Lehramt', #  (3)1
      'Gesundheits- und Kinderkrankenpflege', #  (3)2
      'Hauswirtschaft- und Familienpflege', #  (3)3
      'sonstiges', #  [Textfeld]
    ]
  end
end

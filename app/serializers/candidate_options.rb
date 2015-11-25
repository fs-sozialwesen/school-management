class CandidateOptions < JsonSerializer
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

  def acceptable?
    [school_graduate?, profession_graduate?, education_graduate?,
      internship_proved, police_certificate, contracts_ok?].compact.all? { |v| v }
  end

  def contracts_ok?
    [education_contract_sent, education_contract_received,
      internship_contract_sent, internship_contract_received].all?(&:present?)
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

# Zulassungsvoraussetzungen:

# Schulabschluss
# ============
# - Hauptschulabschluss
# - Realschulabschluss
# - Erweiterter Realschulabschluss
# - Allgem. Hochschulreife
# - Fachhochschulreife FOS Soziales
# - Fachhochschulreife FOS andere Fachrichtung
# - Fachhochschulreife FGym
# - Fachhochschulreife Gym
#
# Bemerkungen: [Textfeld]
#
# Berufsabschluss
# ==============
# - kein
# - Kinderpflege (2)1
# - Sozialassistenz (2)1
# - sozialpflegerische Berufe (2)2: [Textfeld]
# - Fremdberuf (2)3: [Textfeld]
# - Lehramt (3)1
# - Gesundheits- und Kinderkrankenpflege (3)2
# - Hauswirtschaft- und Familienpflege (3)3
# - sonstiges [Textfeld]
#
# Praktische Tätigkeit
# ===============
# (wenn kein Beruf und Schulabschluss nicht FOS Soz ODER Beruf fachfremd)
#
# - mind. 600h
# - 1jhr.
#  - BFD
#  - FSJ
#  - FÖJ
#  - sonstiges
# - 4j einschlägige Tätigkeit

# Dokumente:

# Zulassungsvoraussetzungen [checkboxes]
# ======================
# - Beglaubigte Kopie Schulabschluss
# - Beglaubigte Kopie Berufsabschluss
# - Nachweis Praktikum
# - Führungszeugnis
#
# Verträge [jeweils mit Datumsfeld]
# ======================
# - Ausbildungsvertrag (Ausgabedatum, Rücklaufdatum)
# - Praktikumsvertrag (Ausgabedatum, Rücklaufdatum)
#
# optional
# ===========
# SEPA
# BaföG
# Schulgeldantrag
#

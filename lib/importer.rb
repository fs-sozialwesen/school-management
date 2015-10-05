module Importer

  def self.import_all
    import_education_subjects
    import_teachers
    import_courses
    import_students
    import_carriers
  end

  def self.encrypt_string(string)
    return unless string.present?
    Rails.env.production? ? string : 'GEBLOCKT'
  end

  def self.encrypt_email(email)
    return unless email.present?
    first, last = email.split '@'
    first = Digest::MD5.hexdigest first
    [first, last].join '@'
  end

  def self.import_education_subjects
    puts 'import education_subjects'
    LegacyDatum.ausbildungsart.each do |legacy_data|
      education_subject            = EducationSubject.new

      education_subject.id         = legacy_data['id']
      education_subject.name       = legacy_data['name']
      education_subject.short_name = legacy_data['shortname']

      education_subject.save!
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(EducationSubject.table_name)

  end

  def self.import_teachers
    puts 'import teachers'
    LegacyDatum.lehrer.each do |legacy_data|
      teacher            = Teacher.new

      teacher.id         = legacy_data['id']
      teacher.email      = encrypt_email(legacy_data['email'])
      teacher.first_name = legacy_data['vorname']
      teacher.last_name  = legacy_data['nachname']
      teacher.gender     = legacy_data['geschlecht'].to_i == 1 ? 'f' : 'm'

      teacher.save!
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Teacher.table_name)
  end

  def self.import_courses
    puts 'import courses'
    LegacyDatum.klassen.each do |legacy_data|
      course                      = Course.new
      course.id                   = legacy_data['id']
      course.education_subject_id = legacy_data['ausbildungsart_id']
      course.name                 = legacy_data['name']
      course.teacher_id           = legacy_data['lehrer_id']
      course.start_date           = legacy_data['start_date']
      course.end_date             = legacy_data['end_date']
      course.save!
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Course.table_name)
  end

  def self.import_students
    puts 'import students'
    LegacyDatum.where(old_table: 'azubi').all.each do |legacy_datum|
      data = legacy_datum.data
      begin
        student            = Student.new
        student.first_name = data['vorname']
        student.last_name  = data['nachname']
        student.email      = encrypt_email(data['email'])
        student.gender     = data['geschlecht'].to_i == 1 ? 'f' : 'm'
        street, number     = data['strasse'], data['hausnummer']
        street             += (" #{number}") if number.present?
        student.street     = encrypt_string street
        student.zip        = data['plz']
        student.city       = data['ort']
        student.phone      = encrypt_string data['telefon']
        student.save!

        # generate_course_membership student, data
        course     = Course.where(id: data['klasse']).first
        membership = student.course_memberships.create! course: course if course

      rescue StandardError => e
        msg = "Student #{data['id']} (#{data['vorname']} #{data['nachname']}): "
        msg += student.errors.full_messages.join(', ')
        puts msg
      end

      # bundesland: Sachsen-Anhalt
      # landkreis: LK Harz
      # pp: 191
      # anleiter_id: 68
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Student.table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(CourseMembership.table_name)
  end

  def self.import_carriers
    puts 'import carriers'
    LegacyDatum.where(old_table: 'traeger').all.each do |legacy_datum|
      data = legacy_datum.data
      carrier                = Carrier.new
      carrier.id             = data['id']
      carrier.name           = data['name_1']
      carrier.email          = encrypt_string data['email']
      street, number         = data['strasse'], data['hausnummer']
      street                 += (" #{number}") if number.present?
      carrier.street         = encrypt_string street
      carrier.zip            = data['plz']
      carrier.city           = data['ort']
      carrier.phone          = encrypt_string data['telefon']
      carrier.fax            = encrypt_string data['telefax']
      carrier.contact_person = encrypt_string "#{data['vorname']} #{data['nachname']}"
      carrier.homepage       = data['homepage']
      carrier.comments       = encrypt_string data['kurzbeschreibung']
      carrier.save!
      # geschlecht: 1
    end


    ActiveRecord::Base.connection.reset_pk_sequence!(Carrier.table_name)
  end


end

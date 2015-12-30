class Organisation < ActiveRecord::Base
  class School < Organisation

    has_many :students, class_name: 'Role::Student', inverse_of: :school, foreign_key: :organisation_id
    has_many :teachers, class_name: 'Role::Teacher', inverse_of: :school, foreign_key: :organisation_id
    has_many :education_subjects, inverse_of: :school

    def add_manager!(person)
      person.create_as_manager! organisation: self
    end

    def add_teacher!(person)
      person.create_as_teacher! organisation: self
    end

    def add_student!(person)
      person.create_as_student! organisation: self
    end

    rails_admin do

      Address. attribute_set.each { |attr| configure(attr.name) { group :address } }
      Contact. attribute_set.each { |attr| configure(attr.name) { group :contact } }

      configure(:students) { pretty_value { "#{bindings[:object].students.count} #{I18n.t('attributes.students')}" } }

      list do
        field :name, :self_link
        field :city
        field :carrier
        field :education_subjects
        field :students
      end

      show do
        fields :name, :carrier, :comments, :education_subjects, :teachers, :students
        fields :street, :zip, :city
        fields :person, :email, :mobile, :phone, :fax, :homepage
      end

      edit do
        fields :name, :carrier, :comments
        fields :street, :zip, :city
        fields :person, :email, :mobile, :phone, :fax, :homepage
      end
    end

  end
end

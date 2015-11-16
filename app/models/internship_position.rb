class InternshipPosition < ActiveRecord::Base

  serialize :address,  Address
  serialize :contact,  Contact
  serialize :housing,  Housing
  serialize :applying, Applying
  serialize :inherits, Inherits

  belongs_to :education_subject, required: true
  belongs_to :internship_offer, inverse_of: :internship_positions, required: true
  has_one :organisation, through: :internship_offer
  # has_many :internships, inverse_of: :internship_position

  # validates :education_subject, presence: true
  # validates :internship_offer, presence: true
  validates :number_of_positions, presence: true

  has_paper_trail

  def display_name
    # [education_subject.short_name, internship_offer.name[0..10]].join(' - ')
    education_subject.short_name
  end

  def education_subject_count
    [education_subject.short_name, number_of_positions].join(': ')
  end

  rails_admin do
    parent InternshipOffer

    # configure :work_area, :enum do
    #   enum { ['Kindertagesstätten', 'Hort', 'Heim', 'Tagesgruppe', 'offene Kinder- und Jugendarbeit', 'Psychiatrie', 'Schule'] }
    # end
    #
    list do
      sort_by :name
      field :organisation
      field :internship_offer
      field :education_subject
      field :number_of_positions
    end

    show do
      field :organisation
      field :internship_offer
      field :education_subject
      field :number_of_positions
    end

    edit do
      group :default do
        field :name
        field :description
        # field :internship_offer do
        #   inline_add false
        #   inline_edit false
        # end
        field :education_subject do
          inline_add false
          inline_edit false
        end
        field :number_of_positions
      end
      # group :contact do
      #   label 'Kontakt'
      #   field :contact_person
      #   field :email
      #   field :phone
      #   field :fax
      #   field :homepage
      # end
      group :address do
        label 'Adresse'
        field :street
        field :zip
        field :city
      end
    end

    # show do
    #   field :name
    #   field :education_subject
    #   field :institution
    #   field :comments
    #   field :accommodation
    # end

  end
end

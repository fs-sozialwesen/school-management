class EducationSubject < ActiveRecord::Base

  belongs_to :school, class_name: 'Organisation::School'
  validates :name, presence: true

  has_paper_trail

  def display_name
    short_name
  end

  # rails_admin do
  #   navigation_label I18n.t(:basic_data)
  #
  #   list do
  #     field :name
  #     field :short_name
  #   end
  # end
end

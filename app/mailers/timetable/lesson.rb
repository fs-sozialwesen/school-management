class Timetable::Lesson < ActiveRecord::Base

  belongs_to :course,  inverse_of: :lessons, required: true
  belongs_to :teacher, inverse_of: :lessons, required: true, class_name: 'Person'
  belongs_to :subject, inverse_of: :lessons, required: true
  belongs_to :room,    inverse_of: :lessons, required: true
  belongs_to :time_block

  validates :date, presence: true

  rails_admin do
    hide
    navigation_label I18n.t(:timetable)

    list do
      field :date
      field :time_block
      field :course
      field :subject
      field :teacher
      field :room
    end

    edit do
      field :date
      field :time_block
      field :course
      field :subject
      field :teacher
      field :room
      field :comments
    end
  end

end

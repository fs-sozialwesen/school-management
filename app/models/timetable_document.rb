class TimetableDocument < ActiveRecord::Base
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_attached_file :document, default_url: '/images/:style/missing.png'
  # validates_attachment_content_type :document, content_type: /\Aimage\/.*\Z/
  validates_attachment :document, presence: true,
    content_type: { content_type: 'application/pdf' },
    size: { in: 0..1.megabytes }

  validates :start_date, :end_date, :year, presence: true
end

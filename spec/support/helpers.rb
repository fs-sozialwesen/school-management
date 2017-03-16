require 'support/helpers/session_helpers'
require 'support/helpers/people_helpers'
require 'support/helpers/course_helpers'
require 'support/helpers/timetable_helpers'
require 'support/helpers/internship_helpers'
require 'support/helpers/clickable_table_helpers'

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::PeopleHelpers, type: :feature
  config.include Features::CourseHelpers, type: :feature
  config.include Features::TimetableHelpers, type: :feature
  config.include Features::InternshipHelpers, type: :feature
  config.include Features::ClickableTableHelpers, type: :feature
end

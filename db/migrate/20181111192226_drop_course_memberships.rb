require_relative './20150928204453_create_course_memberships.rb'

class DropCourseMemberships < ActiveRecord::Migration
  def change
    revert CreateCourseMemberships
  end
end

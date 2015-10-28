class InternshipPositionsController < ApplicationController

  def index
    @internship_positions = InternshipPosition.all
  end

end

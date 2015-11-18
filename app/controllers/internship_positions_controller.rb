class InternshipPositionsController < ApplicationController

  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize InternshipPosition

    @search_form          = SearchForm.new params
    @internship_positions = @search_form.internship_positions.all
  end

  def show
    @internship_position = InternshipPosition.find params[:id]
    authorize @internship_position
  end

  class SearchForm
    attr_reader :city, :housing, :applying_by

    def initialize(params)
      %i(city housing applying_by).each { |filter| params.delete filter } if params[:submit] == 'clear'
      @city        = params[:city]
      @housing     = {'yes' => true, 'no' => false}[params[:housing]]
      @applying_by = params[:applying_by]
      @applying_by = applying_by.in?(%w(mail email phone)) ? ('by_' + applying_by).to_sym : nil
    end

    def internship_positions
      InternshipPosition.
        by_city(city).
        housing(housing).
        applying_by(applying_by).
        joins(:organisation).
        includes(:organisation).
        order("internship_positions.address->>'city'")
    end

    def cities
      internship_positions.all.map { |ip| ip.address.city }.compact.uniq.sort
    end

  end

end

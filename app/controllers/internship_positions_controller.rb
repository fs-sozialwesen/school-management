class InternshipPositionsController < ApplicationController

  def index

    @search_form = SearchForm.new params, current_user

    @internship_positions = InternshipPosition.
      includes(internship_offer: :organisation).
      where(@search_form.filter_criteria).
      order("internship_offers.address->>'city'").
      all

    @cities = @internship_positions.map{ |ip| ip.internship_offer.address.city }.compact.uniq.sort
  end

  def show
    @internship_position = InternshipPosition.find params[:id]
    @internship_offer = @internship_position.internship_offer
  end

  class SearchForm
    attr_reader :params, :user, :filter_params, :housing, :applying_by, :city

    def initialize(params, user)
      @params        = params
      @user          = user
      @filter_params = %i(city housing applying_by)
      filter_params.each { |filter| params.delete filter } if params[:submit] == 'clear'
      @housing       = {'yes' => true, 'no' => false}[params[:housing]]
      @applying_by   = params[:applying_by]
      @applying_by   = applying_by.in?(%w(mail email phone)) ? ('by_' + applying_by).to_sym : nil
      @city          = params[:city]
    end

    def filter_criteria

      criteria = {}

      criteria[:internship_offers] = {id: internship_offers.pluck(:id)} unless params[:submit] == 'clear'
      criteria[:education_subject] = user.as_student.education_subject  if user.student?

      criteria
    end

    def internship_offers
      InternshipOffer.by_city(city).housing(housing).applying_by(applying_by)
    end

  end

end

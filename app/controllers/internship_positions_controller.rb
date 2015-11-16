class InternshipPositionsController < ApplicationController

  def index

    if params[:submit] == 'clear'
      %i(city housing by_email).each { |filter| params.delete filter}
    end

    student = current_user.as_student

    internship_offers = InternshipOffer
    internship_offers = internship_offers.with_housing    if params[:housing] == 'yes'
    internship_offers = internship_offers.without_housing if params[:housing] == 'no'
    internship_offers = internship_offers.by_email if params[:by_email]
    if params[:city].present?
      internship_offers = internship_offers.where('address @> ?', {city: params[:city]}.to_json)
    end
    ids = internship_offers.pluck(:id)
    # filter = { education_subject: student.education_subject, internship_offers: {id: ids}}
    filter = { education_subject: EducationSubject.last, internship_offers: {id: ids}}

    @internship_positions = InternshipPosition.
      includes(internship_offer: :organisation).
      where(filter).
      order("internship_offers.address->>'city'").
      all

    @cities = @internship_positions.map{ |ip| ip.internship_offer.address.city }.compact.uniq.sort
  end

  def show
    @internship_position = InternshipPosition.find params[:id]
    @internship_offer = @internship_position.internship_offer
  end

end

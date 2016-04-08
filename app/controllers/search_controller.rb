class SearchController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize :search
    @query = params[:q]
    @result = prepare_results PgSearch.multisearch(@query)
  end

  private

  def prepare_results(search_results)
    grouped_results = {}
    search_results = search_results.to_a.map(&:searchable)
    search_results.each do |result|
      if result.is_a?(Person)
        result.roles.map(&:class).each do |klass|
          grouped_results[klass] ||= []
          grouped_results[klass] << result
        end
      else
        grouped_results[result.class] ||= []
        grouped_results[result.class] << result
      end
    end
    grouped_results
  end
end

# class CandidatesFilter
class CandidatesFilter
  attr_reader :params, :scope, :invited, :status, :answer, :result, :statuses, :date

  def initialize(params, scope = Candidate)
    @params   = params
    @scope    = scope.includes(:person).order(order_options)
    @statuses = Candidate.statuses
    @status   = params[:status].to_s
    @invited  = { 'yes' => true, 'no' => false }[params[:interview_invited]]
    @answer   = params[:interview_answer]
    @result   = params[:interview_result]
    @date     = params[:interview_date]
  end

  def perform
    filter_status
    filter_invited
    filter_answer
    filter_result
    filter_date
    @scope
  end

  private

  def filter_status
    @scope = scope.where(status: @statuses[status]) if status.in? @statuses.keys
  end

  def filter_invited
    @scope = filter_interview(invited: invited) if invited.in?([true, false])
  end

  def filter_answer
    @scope = filter_interview(answer: answer) if answer.present?
  end

  def filter_result
    @scope = filter_interview(result: result) if result.present?
  end

  def filter_date
    @scope = filter_interview(date: date) if date.present?
  end

  def filter_interview(filter)
    scope.where('interview @> ?', filter.to_json)
  end

  def order_options
    return 'people.first_name, date' if params[:sort] == 'first_name'
    return 'people.last_name, date'  if params[:sort] == 'last_name'
    :date
  end
end

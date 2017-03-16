# class CandidatesFilter
class CandidatesFilter
  attr_reader :params, :scope, :invited, :status, :answer, :result, :statuses, :date, :year,
              :education_contract_received, :career_changer

  def initialize(params, scope = Candidate)
    @params                      = params
    @scope                       = scope.order(order_options)
    @statuses                    = Candidate.statuses
    @status                      = params[:status].to_s
    @invited                     = { 'yes' => true, 'no' => false }[params[:interview_invited]]
    @answer                      = params[:interview_answer]
    @result                      = params[:interview_result]
    @date                        = params[:interview_date]
    @year                        = (params[:year] || Date.current.year).to_i
    @education_contract_received = { 'yes' => true, 'no' => false }[params[:education_contract_received]]
    @career_changer              = { 'yes' => true, 'no' => false }[params[:career_changer]]
  end

  def perform
    filter_status
    filter_invited
    filter_answer
    filter_result
    filter_date
    filter_year
    filter_education_contract_received
    filter_career_changer
    @scope
  end

  private

  def filter_status
    @scope = scope.where(status: @statuses[status]) if status.in? @statuses.keys
  end

  def filter_invited
    return unless invited.in?([true, false])
    @scope = if invited
      filter_interview(invited: invited)
    else
      scope.where.not('interview @> ?', {invited: true}.to_json)
    end
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

  def filter_year
    @scope = scope.where(year: year) if year.present?
  end

  def filter_career_changer
    @scope = scope.where(career_changer: career_changer) if career_changer.in?([true, false])
  end

  def filter_education_contract_received
    return unless @education_contract_received.in?([true, false])
    @scope = if @education_contract_received
      scope.where.not(education_contract_received: nil)
    else
      scope.where(education_contract_received: nil)
    end
  end

  def filter_interview(filter)
    return scope.where.not("interview ? 'date'") if filter[:date] == 'none'
    scope.where('interview @> ?', filter.to_json)
  end

  def order_options
    return 'first_name, date' if params[:sort] == 'first_name'
    return 'last_name, date'  if params[:sort] == 'last_name'
    :date
  end
end

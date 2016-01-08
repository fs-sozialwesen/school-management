module CandidatesHelper

  def human_status_name(status)
    t("activerecord.attributes.candidate.status/#{status}")
  end

  def human_result_name(result)
    t("activerecord.attributes.candidate.interview.result/#{result}")
  end

  def human_answer_name(answer)
    t("activerecord.attributes.candidate.interview.answer/#{answer}")
  end

  def interview_result_options
    (Interview::RESULTS + ['repeat']).each_with_object({}) do |result, options|
      options[human_result_name(result)] = result
    end
  end

  def interview_answer_options
    Interview::ANSWERS.each_with_object({}) do |answer, options|
      options[human_answer_name(answer)] = answer
    end
  end

  def progress_bar(candidate)
    width = progress_bar_width candidate.progress
    css_class = 'progress-bar progress-bar-' + progress_bar_class(candidate)
    content_tag(:div, class: 'progress', title: human_status_name(candidate.status)) do
      content_tag(:div, nil, class: css_class, style: "width: #{width}%;")
    end
  end

  def progress_bar_class(candidate)
    return 'danger'  if candidate.rejected?
    return 'success' if candidate.accepted?
    'warning'
  end

  def progress_bar_width(progress)
    case progress
    when -1 then 100
    when  0 then  10
    when  1 then  40
    when  2 then  70
    when  3 then 100
    end
  end
end

module ApplicationHelper
  def bool_icon(val, yes_title = 'yes', no_title = 'no')
    label, icon, title = case val
    when true then ['success', 'ok-sign', yes_title]
    when false then ['warning', 'question-sign', no_title]
    else ['default', 'minus-sign', '']
    end

    content_tag :span, class: 'label label-' + label, title: title do
      content_tag :span, nil, class: 'glyphicon glyphicon-' + icon
    end
  end

  def ldate(date)
    return '' unless date.present?
    l date
  end

  def gt(key, person, options = {})
    return '' if person.gender.blank?
    t "#{key}_#{person.gender}", options
  end
end

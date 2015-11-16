module ApplicationHelper
  def bool_icon(val)
    css_class = 'glyphicon glyphicon-'
    css_class += val ? 'ok' : 'minus'
    content_tag :span, nil, class: css_class
  end
end

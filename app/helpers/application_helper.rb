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

  def ldate(date, options = nil)
    return '' unless date.present?
    l date, options
  end

  def gt(key, person, options = {})
    return '' if person.gender.blank?
    t "#{key}_#{person.gender}", options
  end

  def menu_item(label, link, active)
    content_tag(:li, class: ('active' if active)) { link_to label, link }
  end

  def menu_item_for(model)
    return people_menu_item_for(model) if model.in?([Manager, Teacher, Student])
    return '' unless policy(model).index?
    controller_name = model.name.tableize
    active = params[:controller] == controller_name
    label  = t(".#{controller_name}")
    link   = url_for model
    menu_item label, link, active
  end

  def people_menu_item_for(model)
    controller_name = model.name.tableize
    return '' unless policy(Person).send("#{controller_name}?")
    active = ((@person && @person.send("#{model.name.underscore}?")) or params[:action] == controller_name)
    label  = t(".#{controller_name}")
    link   = send "#{controller_name}_people_path"
    menu_item label, link, active
  end

end

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

  def menu_item(label:, link:, active:)
    content_tag(:li, class: ('active' if active)) { link_to label, link }
  end

  def menu_item_for(model_or_scope)
    model, scope = model_or_scope.is_a?(Symbol) ? [Person, model_or_scope] : [model_or_scope, :index]
    return '' unless policy(model).send("#{scope}?")
    menu_item (scope == :index) ? simple_menu_item_for(model) : people_menu_item_for(scope.to_s)
  end

  def panel_box(title: nil, &block)
    content = capture(&block)
    content_tag(:div, class: 'panel panel-default') do
      head = panel_heading title:   title
      body = content_tag(:div, content, class: 'panel-body')
      [head, body].join.html_safe
    end
  end

  def panel_heading(title: nil)
    return unless title
    content_tag(:div, class: 'panel-heading') { content_tag(:div, title, class: 'panel-title') }
  end

  def link_to_email(address)
    return '' if address.blank?
    link_to address, "mailto:#{address}"
  end

  def bool(val, yes: 'x', no: '-')
    val ? yes : no
  end
  private

  def simple_menu_item_for(model)
    {
      label:  model.model_name.human(count: 2),
      link:   url_for(model),
      active: params[:controller] == model.name.tableize
    }
  end

  def people_menu_item_for(scope)
    singular_scope = scope.singularize
    {
      label:  t(singular_scope, scope: [:activerecord, :models], count: 2),
      link:   send("#{scope}_people_path"),
      active: ((@person && @person.send("#{singular_scope}?")) or params[:action] == scope)
    }
  end

end

class window.Modal
  constructor: (selector) ->
    @elem = $(selector)

    @footer().find('button.btn-primary').click =>
      @body().find('form').submit()

  on: (event, func)  => @elem.on event, func
  onShow: (func)     => @elem.on 'show.bs.modal', func
  setTitle: (title)  => @title().html title
  setBody: (content) => @body().html content
  show: => @elem.modal('show')
  hide: => @elem.modal('hide')

  title:  => @elem.find('.modal-title')
  body:   => @elem.find('.modal-body')
  footer: => @elem.find('.modal-footer')

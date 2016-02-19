class window.TimeTable
  constructor: (tableSel, modalSel) ->
    @table = $(tableSel)
    @modal = new Modal(modalSel)
    @init()
    
  init: =>
    @modal.on 'ajax:success', (event, data) => @updateTimeTable(data)
    @modal.on 'ajax:error',   (_, xhr)      => @modal.setBody(xhr.responseText)
    @setClickEvents()

  setClickEvents: =>
    @table.find('a.add-lesson, a.edit-lesson, a.copy-lesson').click @modalLinkClicked
    @table.find('a.delete-lesson').click @deleteLinkClicked

  modalLinkClicked: (event) =>
    event.preventDefault()
    link = $(event.currentTarget)
    url = link.attr('href')
    $.get url, (data) => @modal.setBody(data)
    @modal.show()

  deleteLinkClicked: (event) =>
    event.preventDefault()
    link = $(event.currentTarget)
    url = link.attr('href')
    $.post url, { _method: 'delete' }, (data) => @updateTimeTable(data)

  updateTimeTable: (content) =>
    tbody = @table.find('tbody')
    tbody.html content
    @setClickEvents()
    @modal.hide()

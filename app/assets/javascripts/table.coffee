$(document).on 'turbolinks:load', ->
  $('table.table-clickable > tbody > tr').click (el) =>
    if $(el.target).is('td')
      url = $(el.currentTarget).data().url
      Turbolinks.visit(url) if url?
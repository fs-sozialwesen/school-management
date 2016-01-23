$ ->
  $('table.table-clickable > tbody > tr').click (el) =>
    url = $(el.currentTarget).data().url
    window.location = url if url?

$(document).on 'turbolinks:load', ->
  $('input.date').each (i, input) ->
    $input = $(input)
    date = $input.val()
    if date isnt ''
      [year, month, day] = date.split('-')
      $input.val [day, month, year].join('.')

    startView = $input.data().startView or 0
    $input.datepicker
      format: 'dd.mm.yyyy'
      startView: startView
      language: "de"
      todayHighlight: true

class window.Pente

  FIELD_SIZE: 19
  P1: 0
  P2: 1

  constructor: (selector) ->
    @selector = selector
    @init()

  init: =>
    @turn = @P1
    @board = {}
    @captured = {}
    @captured[@P1] = 0
    @captured[@P2] = 0
    @winner = null
    @renderGame()

  players: => [@P1, @P2]

  fieldFor: (x, y) => "#{x};#{y}"
  setStone: (x, y) =>
    console.log @board[@fieldFor(x, y)]
    return unless @board[@fieldFor(x, y)] == undefined
    @board[@fieldFor(x, y)] = @turn
    @winner = @turn if @checkFive x, y
    @checkCaptured x, y
    @winner = @turn if @captured[@turn] == 10
    @renderBoard()
    @turn = @otherPlayer()

  otherPlayer: -> 1 - @turn

  checkFive: (x, y) =>
    for x_offset in [-1, 0, 1]
      for y_offset in [-1, 0, 1] when !(x_offset == 0 and y_offset == 0)
        fields = (@board[@fieldFor(x + (step * x_offset), y + (step * y_offset))] for step in [1, 2, 3, 4])
        return true if fields.join() == [@turn, @turn, @turn, @turn].join()
    false

  checkCaptured: (x, y) ->
    for x_offset in [-1, 0, 1]
      for y_offset in [-1, 0, 1] when !(x_offset == 0 and y_offset == 0)
        startField =  @fieldFor(x + (x_offset * 3), y + (y_offset * 3))
        otherField1 = @fieldFor(x + (x_offset * 2), y + (y_offset * 2))
        otherField2 = @fieldFor(x +  x_offset,      y +  y_offset)
        if @board[startField] == @turn && @board[otherField1] == @otherPlayer() && @board[otherField2] == @otherPlayer()
          delete @board[otherField1]
          delete @board[otherField2]
          @captured[@turn] = @captured[@turn] + 2

  renderGame: =>
    $game = $ @selector
    imageUrl = $game.data().fieldImageUrl
    table = $('<table id="board"></table>"')
    for y in [0...@FIELD_SIZE]
      row = $ '<tr></tr>'
      for x in [0...@FIELD_SIZE]
        td = $("<td class='field' data-x='#{x}' data-y='#{y}'></td>")
        td.click (event) =>
          data = event.currentTarget.dataset
          @setStone(parseInt(data.x), parseInt(data.y))
        row.append td.html("<img src='#{imageUrl}'><span></span>")
      table.append(row)
    $game.html table

  renderBoard: =>
    $board = $ '#board'
    $board.find('td span').html('')
    rows = for y in [0...@FIELD_SIZE]
      row = for x in [0...@FIELD_SIZE]
        player = @board[@fieldFor(x, y)]
        if player != undefined
          $board.find("[data-x=#{x}][data-y=#{y}] span").html("<img width='30' src='#{@stoneImage(player)}'>")
  stoneImage: (player) =>
    $(@selector).data("p#{player}StoneUrl")

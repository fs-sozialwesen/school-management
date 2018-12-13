class window.Pente

  FIELD_SIZE: 19
  P1: 0
  P2: 1

  constructor: () ->
    @turn = @P1
    @board = {}
    @captured = {}
    @captured[@P1] = 0
    @captured[@P2] = 0
    @winner = null
    $('#board td').click (event) =>
      data = event.currentTarget.dataset
      @setStone(parseInt(data.x), parseInt(data.y))

  players: => [@P1, @P2]

  fieldFor: (x, y) => "#{x};#{y}"
  setStone: (x, y) =>
    throw new Error('invalid move') unless @board[@fieldFor(x, y)] == undefined
    @board[@fieldFor(x, y)] = @turn
    @winner = @turn if @checkFive x, y
    @checkCaptured x, y
    @winner = @turn if @captured[@turn] == 10
    @render()
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
  render: =>
    $board = $ '#board'
    $board.find('td').removeClass('player0').removeClass('player1')
    rows = for y in [0...@FIELD_SIZE]
      row = for x in [0...@FIELD_SIZE]
        val = @board[@fieldFor(x, y)]
        if val != undefined
          $board.find("[data-x=#{x}][data-y=#{y}]").addClass("player#{val}")

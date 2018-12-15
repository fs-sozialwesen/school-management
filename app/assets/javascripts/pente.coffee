class window.Pente

  FIELD_SIZE: 19
  P1: 0
  P2: 1

  constructor: (selector) ->
    @game = $ selector
    @renderGame()
    @init()

  init: =>
    @turn = @P1
    @board = {}
    @captured = {}
    @captured[@P1] = 0
    @captured[@P2] = 0
    @winner = null
    @renderStones()
    @renderPlayers()

  players: => [@P1, @P2]

  fieldFor: (x, y) => "#{x};#{y}"

  setStone: (x, y) =>
    return unless @board[@fieldFor(x, y)] == undefined
    return unless @winner == null
    @board[@fieldFor(x, y)] = @turn
    @winner = @turn if @checkFive()
    @checkCaptured x, y
    @winner = @turn if @captured[@turn] == 5
    @turn = @otherPlayer()

    @renderStones()
    @renderPlayers()

  otherPlayer: -> 1 - @turn

  checkFive: =>
    for x in [1..@FIELD_SIZE]
      for y in [1..@FIELD_SIZE]
        for x_offset in [-1, 0, 1]
          for y_offset in [0, 1] when !(x_offset == 0 and y_offset == 0)
            fields = (@board[@fieldFor(x + (step * x_offset), y + (step * y_offset))] for step in [0, 1, 2, 3, 4])
            return true if fields.join() == [@turn, @turn, @turn, @turn, @turn].join()
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
          @captured[@turn] = @captured[@turn] + 1

  renderGame: =>
    boardHtml = $('<div id="board">')
    gridFields = "repeat(#{@FIELD_SIZE}, 40px)"
    boardHtml.css display: 'inline-grid', gridTemplateColumns: gridFields, gridTemplateRows: gridFields
    for x in [1..@FIELD_SIZE]
      for y in [1..@FIELD_SIZE]
        field = $("<div class='field' data-x='#{x}' data-y='#{y}'><span class='stone'>")
        field.css gridColumn: y, gridRow: x
        field.click (event) =>
          data = event.currentTarget.dataset
          @setStone(parseInt(data.x), parseInt(data.y))
        boardHtml.append(field)
    @game.append boardHtml
    @game.append '<div id="players">'

  renderStones: =>
    $board = @game.find '#board'
    $board.removeClass('player0 player1')
    $board.addClass("player#{@turn}") if @winner == null
    $board.find('.field span').removeClass('player0 player1')
    rows = for y in [1..@FIELD_SIZE]
      row = for x in [1..@FIELD_SIZE]
        player = @board[@fieldFor(x, y)]
        if player != undefined
          $board.find("[data-x=#{x}][data-y=#{y}] span").addClass "player#{player}"

  renderPlayers: =>
    players = @game.find '#players'
    players.html ''

    newGame = $ '<a href="#">Neues Spiel</a>'
    newGame.addClass 'btn btn-primary'
    newGame.click => @init()
    players.append newGame

    for player in @players()
      p = $ '<div>'
      p.addClass "player#{player}"
      p.append "<h3><span class='stone player#{player}'></span> Spieler #{player + 1}</h3>"
      p.addClass 'current' if player == @turn && @winner == null
      p.addClass 'winner' if player == @winner

      captured = $ '<p>'
      for i in [0...@captured[player]]
        captured.append "<span class='stone player#{1 - player}'>"
        captured.append "<span class='stone player#{1 - player} second'>"
      p.append captured

      players.append p



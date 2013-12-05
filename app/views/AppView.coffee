class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .nextGame-button": -> @newGame()

  initialize: ->
    @render()
    @model.on 'change:gameOver', @addNextGameButton, @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  addNextGameButton: ->
    @$el.find('button').last().after('<button class="nextGame-button">Next Game</button>')

  newGame: ->
    @model.set 'playerHand', @model.get('deck').dealPlayer()
    @model.set 'dealerHand', @model.get('deck').dealDealer()
    @model.set 'gameOver', @model.set('gameOver', false)
    @model.listeners()
    @render()
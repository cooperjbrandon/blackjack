class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="betting-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .nextGame-button": -> @newGame()

  initialize: ->
    @betView = new BetView(model: @model.get 'bet')
    @render(@betView)
    @model.on 'change:gameOver', @calculateWinLoss, @
    @model.on 'change:gameOver', @addNextGameButton, @
    @model.get('bet').on 'change:betAmount', @showCards, @

  render: (betView) ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.betting-container').html betView.el

  addNextGameButton: ->
    @$el.find('.stand-button').after('<button class="nextGame-button">Next Game</button>')

  newGame: ->
    @model.set 'playerHand', @model.get('deck').dealPlayer()
    @model.set 'dealerHand', @model.get('deck').dealDealer()
    @model.set 'gameOver', @model.set('gameOver', false)
    @model.listeners()
    @render(@betView)

  calculateWinLoss: ->
    if @model.get('gameOver') == true
      result = @model.get('result')
      @model.get('bet').calculateBankRoll(result)

  showCards: ->
    if @model.get('bet').get('betAmount') != null
      @model.get('playerHand').at(0).flip()
      @model.get('playerHand').at(1).flip()
      @model.get('dealerHand').at(1).flip()

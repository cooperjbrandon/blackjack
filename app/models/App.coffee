#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameOver', false
    @set 'bet', new Bet()
    @set 'result', null
    @listeners()

  gameOver: ->
    playerScore =
      if @get('playerHand').scores()[1] and @get('playerHand').scores()[1] <= 21
        @get('playerHand').scores()[1]
      else
        @get('playerHand').scores()[0]

    dealerScore =
      if @get('dealerHand').scores()[1] and @get('dealerHand').scores()[1] <= 21
        @get('dealerHand').scores()[1]
      else
        @get('dealerHand').scores()[0]

    if playerScore > 21
      @set 'result', 'loss'
      alert 'You suck lollipops'
    else if dealerScore > playerScore and dealerScore <= 21
      @set 'result', 'loss'
      alert 'You suck lollipops'
    else if dealerScore == playerScore
      @set 'result', 'tie'
      alert 'You both suck'
    else
      @set 'result', 'win'
      alert 'Bau$$!'

    @set 'gameOver', true

  slowDown: => @get('dealerHand').hit()

  listeners: ->
    # playerHand listeners
    @get('playerHand').on 'stand', (->
      @get('dealerHand').at(0).flip()
      if @get('playerHand').scores()[0] <= 21
        setTimeout @slowDown, 1500
      else
        @get('dealerHand').stand()
      ), @
    @get('playerHand').on 'hit', (->
      if @get('playerHand').scores()[0] > 21 then @get('playerHand').stand()
      ), @

    # dealerHand listeners
    @get('dealerHand').on 'hit', (->
      setTimeout @slowDown, 1500
    ), @
    @get('dealerHand').on 'stand', @gameOver, @
#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # playerHand listeners
    @get('playerHand').on 'stand', (->
      @get('dealerHand').at(0).flip()
      if @get('playerHand').scores()[0] <= 21
        @get('dealerHand').hit()
      else
        @get('dealerHand').stand()
      ), @
    @get('playerHand').on 'hit', (->
      if @get('playerHand').scores()[0] > 21 then @get('playerHand').stand()
      ), @

    # dealerHand listeners
    @get('dealerHand').on 'hit', (-> @get('dealerHand').hit()), @
    @get('dealerHand').on 'stand', @gameOver, @

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
      alert 'You suck lollipops'
    else if dealerScore > playerScore and dealerScore <= 21
      alert 'You suck lollipops'
    else if dealerScore == playerScore
      alert 'You both suck'
    else
      alert 'Bau$$!'

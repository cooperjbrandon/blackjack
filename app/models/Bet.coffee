class window.Bet extends Backbone.Model

  initialize: ->
    @set
      dollars: 500
      betAmount: null

  calculateBankRoll: (result) ->
    betAmount = @get 'betAmount'
    currentBankAmount = @get 'dollars'
    if result == 'win'
      @set 'dollars', currentBankAmount + parseInt betAmount
      @set 'betAmount', null
    else if result == 'loss'
      @set 'dollars', currentBankAmount - betAmount
      @set 'betAmount', null
    else
      @set 'dollars', currentBankAmount
      @set 'betAmount', null
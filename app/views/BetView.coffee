class window.BetView extends Backbone.View

  className: 'bet'

  template: _.template '
    <span><p>Bank Account: $<%= dollars %></p></span>
    Enter Bet Amount: <input type="text" name="betAmount" id="betAmount" value="0">
    <button class="bet-button">Bet</button>
  '
  events:
    "click .bet-button": -> @setBet()

  initialize: ->
    @render()
    @model.on 'change:dollars', @render, @

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes

  setBet: ->
    @$el.find('button').after('<p class="bettor">('+ @$('#betAmount').val()+')</p>')
    @model.set 'betAmount', @$('#betAmount').val()

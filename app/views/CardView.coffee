class window.CardView extends Backbone.View

  className: 'card'

  templateCards: _.template '<img class="card" src="app/cardImages/cards/<%= rankName %>-<%= suitName %>.png"></img>'
  templateCardBack: _.template '<img class="card" src="app/cardImages/card-back.png"></img>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    if @model.get 'revealed'
      @$el.html @templateCards @model.attributes
    else
      @$el.html @templateCardBack @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'



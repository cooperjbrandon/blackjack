class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img width="100px" height="140px" src="app/cardImages/cards/<%= rankName %>-<%= suitName %>.png"></img>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'



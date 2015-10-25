class window.AppView extends Backbone.View
  template: _.template '
    <div class="messages"></div>
    <div class="bet-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="redeal-button">Redeal</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .redeal-button': -> @model.redeal()

  initialize: ->
    @render()
    @model.on 'redeal', => @render()
    @model.on 'change', => @render()
    @model.on 'gameOver', => @disableButtons()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bet-container').html new BetView(model: @model.get 'bet').el
    @$('.messages').text @model.get 'message'

  disableButtons: ->
    $('.hit-button').prop('disabled', true)
    $('.stand-button').prop('disabled', true)
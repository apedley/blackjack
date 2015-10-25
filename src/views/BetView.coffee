class window.BetView extends Backbone.View
  className: 'bet'

  template: _.template '
    <h2>Bet</h2>
    <p>Chips: <%= chips %></p>
    <p>Current Bet: <%= currentBet %></p>
    <button class="bet-ten-button">Bet Ten</button>
    <button class="bet-fifty-button">Bet Fifty</button>
    <button class="bet-hundred-button">Bet Hundred</button>
  '
  events:
    'click .bet-ten-button': -> @model.bet(10)
    'click .bet-fifty-button': -> @model.bet(50)
    'click .bet-hundred-button': -> @model.bet(100)
  initialize: ->
    @render()
    @model.on 'change', => @render() 

  render: ->
    @$el.html @template @model.attributes
class window.Bet extends Backbone.Model
  initialize: (params) ->
    @set
      chips: params.chips
      currentBet: 0
      betOpen: true

  bet: (amount) ->
    if !@get 'betOpen' then return
    chips = @get 'chips'
    currentBet = @get 'currentBet'

    if amount > chips then amount = chips
    @set 'chips', chips - amount
    @set 'currentBet', currentBet + amount
    
  betAll: ->
    chips = @get 'chips'
    @set 'chips', 0
    @set 'currentBet', chips

  win: ->
    chips = @get 'chips'
    currentBet = @get 'currentBet'
    @set 'chips', chips + (currentBet * 2)
    @set 'currentBet', 0

  lose: ->
    @set 'currentBet', 0
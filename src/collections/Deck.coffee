class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @shuffle()

  dealPlayer: -> 
    hand = new Hand [@pop(), @pop()], @
    @trigger 'winningHand', @
    if hand.maxScore() == 21
      @trigger 'winningHand', @
    hand

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  shuffle: ->
    @reset()
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
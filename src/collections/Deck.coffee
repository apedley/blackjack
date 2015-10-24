class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    jack = new Card {rank: 11, suit: 2}
    ace = new Card {rank: 1, suit: 2}

    hand = new Hand [@pop(), @pop()], @
    # hand = new Hand([jack, ace], @)
    console.log hand.maxScore()
    @trigger 'winningHand', @
    if hand.maxScore() == 21
      @trigger 'winningHand', @
    hand

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true


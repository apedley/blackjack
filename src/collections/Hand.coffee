class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @trigger 'makePlay', @
    @add(@deck.pop())
    if (@minScore() > 21)
      @trigger 'bust', @
      # return null
    @last()

  stand: ->
    @trigger 'makePlay', @
    @trigger 'stand', @


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  maxScore: -> 
    Math.max(@scores()[0], @scores()[1])

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]



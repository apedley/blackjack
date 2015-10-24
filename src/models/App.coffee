# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @redeal()
    @set 'message', 'Good luck!'


  bust: ->
    @set 'message', 'Bust!'
    @trigger 'gameOver', @

  playDealer: ->
    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'
    dealerHand.first().set('revealed', true)
    while dealerHand.scores()[1] < 17
      dealerHand.hit()
    @gameOver()

  redeal: ->
    @set 'message', 'Good luck!'
    deck = @get 'deck'
    if deck.length < 10
      deck.shuffle()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    if playerHand.maxScore() == 21
      @gameOver()
    playerHand.on 'bust', @bust, @
    playerHand.on 'stand', @playDealer, @
    @trigger 'redeal', @

  blackjack: ->
    alert('blackjack!')

  gameOver: ->
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    if playerHand.maxScore() > dealerHand.maxScore() or dealerHand.minScore() > 21
      @set 'message', 'You win!'
    else
      @set 'message', 'Dealer wins!'
    @trigger 'gameOver', @

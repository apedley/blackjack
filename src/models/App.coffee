# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'bet', bet = new Bet({chips: 1000})
    @redeal()
    @set 'message', 'Good luck!'

  bust: ->
    @set 'message', 'Bust!'
    bet = @get 'bet'
    bet.lose()
    @trigger 'gameOver', @

  playDealer: ->
    bet = @get 'bet'
    bet.set 'betOpen', false
    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'
    dealerHand.first().set('revealed', true)
    while dealerHand.scores()[1] < 17
      dealerHand.hit()
    @gameOver()

  redeal: ->
    @set 'message', 'Good luck!'
    bet = @get 'bet'
    if bet.get('chips') is 0 

      alert('You lost! Have some more chips..')
      bet.set 'chips', 1000
    bet.set 'betOpen', true
    deck = @get 'deck'
    if deck.length < 10
      deck.shuffle()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    if playerHand.maxScore() == 21
      @gameOver()
    playerHand.on 'makePlay', @closeBet, @
    playerHand.on 'bust', @bust, @
    playerHand.on 'stand', @playDealer, @
    @trigger 'redeal', @

  closeBet: ->
    bet = @get 'bet'
    bet.set 'betOpen', false

  blackjack: ->
    alert('blackjack!')

  gameOver: ->
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    if playerHand.maxScore() > dealerHand.maxScore() or dealerHand.minScore() > 21
      @set 'message', 'You win!'
      bet = @get 'bet'
      bet.win()
    else
      @set 'message', 'Dealer wins!'
      bet = @get 'bet'
      bet.lose()
    @trigger 'gameOver', @

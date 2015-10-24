assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    sinon.spy(hand, 'trigger') 

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49
    it 'should bust when the player total is over 21', ->
      hand.reset()

      king = new Card({rank: 0, suit: 'Diamonds'})
      ace = new Card({rank: 1, suit: 'Diamonds'})
      queen = new Card({rank: 12, suit: 'Diamonds'})

      hand.add [king, ace, queen]
      assert.strictEqual hand.length, 3
      hand.hit()
      expect(hand.trigger).to.have.been.calledWith 'bust'

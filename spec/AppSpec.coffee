assert = chai.assert

describe 'app', ->
  app = null
  beforeEach ->
    app = new App()
    
  it 'should deal new hands', ->
    expect(app.get('deck').length).to.equal(48)

  it 'should play cards for the dealer', ->
    cardCount = app.get('deck').length
    app.playDealer()
    expect(cardCount).to.not.equal(app.get('deck').length)

  it 'should not hit dealer on 17 or over', ->
    seven = new Card({rank: 7, suit: 2})
    ten = new Card({rank: 10, suit: 2})
    app.set('dealerHand', new Hand([seven, ten], app.get('deck')))
    cardCount = app.get('deck').length
    app.playDealer()
    expect(cardCount - 4).to.equal(app.get('deck').length)

  it 'should end the game if player is dealt 21', ->
    ace = new Card({rank: 1, suit: 2})
    king = new Card({rank: 0, suit: 2})
    deck = app.get('deck')
    deck.push(ace)
    deck.push(king)

    sinon.spy(app, "gameOver")
    app.redeal()
    expect(app.gameOver).to.have.been.called
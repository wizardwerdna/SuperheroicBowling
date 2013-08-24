describe "Features: ", ->

  beforeEach module "bowlingApp"
  beforeEach module "views/main.html"

  app = {}

  beforeEach inject ($compile, $rootScope)->
    html = '''
      <div ng-app="bowlingApp">
        <div ng-view=""></div>
      </div>
    '''
    app = ($compile html) $rootScope.$new()
    $rootScope.$digest()

  rollButtons = -> app.find('.roll')
  roll = (pins) -> rollButtons().eq(pins).click()
  reset = -> app.find('.reset').click()
  rollsDisplay = -> app.find('.roll-display').text()

  describe "Data Entry", ->

    it "has a header", ->
      (expect app.find('h1').text()).toBe "Superheroic Bowling"

    describe "input means", ->
      it "should have 11 roll buttons", ->
        (expect rollButtons().length).toBe 11
      it "should have a reset button", ->
        (expect app.find('.reset').length).toBe 1

    describe "output means", ->
      it "should display initially empty list of rolls", ->
        (expect rollsDisplay()).toBe ""

    describe "bowling means", ->
      it "should display a gutter roll", ->
        roll(0)
        (expect rollsDisplay()).toBe "-"
      it "should display a pin drop roll", ->
        roll(5)
        (expect rollsDisplay()).toBe "5"
      it "should display two rolls", ->
        roll(3); roll(4)
        (expect rollsDisplay()).toBe "34"

      it "should display an empty list upon reset", ->
        roll(3)
        reset()
        (expect rollsDisplay()).toBe ""

  frameScoresDisplay = -> app.find('.frameScores').text()
  frameScore = -> app.find('.frame-score')
  frameScoreArray = -> frameScore().get().map((e)->$(e).text()).filter((e)->e!="")
  frameScoresDisplay = -> "[#{frameScoreArray().join(',')}]"

  describe "Scoring", ->
    describe "output means", ->
      it "should display an initially empty set list of frame scores", ->
        (expect frameScoresDisplay()).toBe "[]"

    describe "should score an incomplete frames", ->
      it "should score a single non-strike roll", ->
        roll(3)
        (expect frameScoresDisplay()).toBe "[]"

    describe "should score a complete frame", ->
      it "should score an open frame", ->
        roll(0); roll(1)
        (expect frameScoresDisplay()).toBe "[1]"
        reset()
        roll(0); roll(0)
        (expect frameScoresDisplay()).toBe "[0]"

  rollDisplay = -> app.find('.roll-display').text()

  describe "Roll Display", ->
    describe "output means", ->
      it "should display an initially empty list of frame scores", ->
        (expect rollDisplay()).toBe ""

      it "should display a single pin roll", ->
        roll(4)
        (expect rollDisplay()).toBe "4"
        reset()
        roll(5)
        (expect rollDisplay()).toBe "5"

      it "should display a gutter ball as a '-'", ->
        roll(0)
        (expect rollDisplay()).toBe "-"
      it "should display a strike as ' X'", ->
        roll(10)
        (expect rollDisplay()).toBe " X"

  describe "User Error Protection", ->
    describe "game over", ->
      it "buttons should be enabled when created", ->
        (expect rollButtons().is(':disabled')).toBeFalsy()

      it "buttons should be enabled when reset", ->
        roll(5)
        reset()
        (expect rollButtons().is(':disabled')).toBeFalsy()

      it "should disable all the pins when the games is over", ->
        roll(10) for i in [1..12]
        (expect rollButtons().is(':enabled')).toBeFalsy()

    describe "on second roll of a frame", ->
      it "disable buttons that would be too large for a spare",->
        roll(3)
        (expect rollButtons().eq(8).is(':disabled')).toBeTruthy()
        (expect rollButtons().eq(10).is(':disabled')).toBeTruthy()
      it "enables buttons that would not be too large for a spare", ->
        roll(3)
        (expect rollButtons().eq(0).is(':enabled')).toBeTruthy()
        (expect rollButtons().eq(7).is(':enabled')).toBeTruthy()
    describe "on the tenth frame", ->
      it "should enable buttons after a first roll strike", ->
        roll(10) for i in [1..10]
        (expect rollButtons().eq(0).is(':enabled')).toBeTruthy()
        (expect rollButtons().eq(10).is(':enabled')).toBeTruthy()
      it "should disable buttons on third roll ater a strike too big for spare", ->
        roll(10) for i in [1..10]
        roll(5)
        (expect rollButtons().eq(5).is(':enabled')).toBeTruthy()
        (expect rollButtons().eq(6).is(':disabled')).toBeTruthy()
        (expect rollButtons().eq(10).is(':disabled')).toBeTruthy()
      it "should leave all buttons enabled after a double", ->
        roll(10) for i in [1..11]
        (expect rollButtons().eq(1).is(':enabled')).toBeTruthy()
        (expect rollButtons().eq(10).is(':enabled')).toBeTruthy()

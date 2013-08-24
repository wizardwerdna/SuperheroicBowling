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

  roll = (pins) -> app.find('.roll').eq(pins).click()
  reset = -> app.find('.reset').click()
  rollsDisplay = -> app.find('.rolls').text()

  describe "Data Entry", ->

    it "has a header", ->
      (expect app.find('h1').text()).toBe "Superheroic Bowling"

    describe "input means", ->
      it "should have 11 roll buttons", ->
        (expect app.find('.roll').length).toBe 11
      it "should have a reset button", ->
        (expect app.find('.reset').length).toBe 1

    describe "output means", ->
      it "should display initially empty list of rolls", ->
        (expect rollsDisplay()).toBe "[]"

    describe "bowling means", ->
      it "should display a gutter roll", ->
        roll(0)
        (expect rollsDisplay()).toBe "[0]"
      it "should display a pin drop roll", ->
        roll(5)
        (expect rollsDisplay()).toBe "[5]"
      it "should display two rolls", ->
        roll(3); roll(4)
        (expect rollsDisplay()).toBe "[3,4]"

      it "should display an empty list upon reset", ->
        roll(3)
        reset()
        (expect rollsDisplay()).toBe "[]"

describe "Features: ", ->

  beforeEach module "bowlingApp"
  beforeEach module "views/main.html"
  beforeEach module "views/bowlingLine.html"

  app = {}

  beforeEach inject ($compile, $rootScope)->
    html = '''
      <div ng-app="bowlingApp">
        <div ng-view=""></div>
      </div>
    '''
    app = ($compile html) $rootScope.$new()
    $rootScope.$digest()

  describe "Bowling Lines", ->
    it "has a header", ->
      (expect app.find('h1').text()).toBe "Superheroic Bowling"

    it "should have three bowling lines", ->
      (expect app.find('.line').length).toBe 3

    it "should bowl independently", ->
      app.find('#line1 .roll').eq(1).click()
      app.find('#line1 .roll').eq(0).click()
      app.find('#line2 .roll').eq(2).click()
      app.find('#line2 .roll').eq(0).click()
      app.find('#line3 .roll').eq(3).click()
      app.find('#line3 .roll').eq(0).click()
      (expect app.find('#line1 .frame-score').text()).toBe '1'
      (expect app.find('#line2 .frame-score').text()).toBe '2'
      (expect app.find('#line3 .frame-score').text()).toBe '3'

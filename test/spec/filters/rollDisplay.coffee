'use strict'

describe 'Filter: rollDisplay', () ->

  # load the filter's module
  beforeEach module 'bowlingApp'

  # initialize a new instance of the filter before each test
  rollDisplay = {}
  beforeEach inject ($filter) ->
    rollDisplay = $filter 'rollDisplay'

  testDisplay = (rolls, result)->
    (expect rollDisplay rolls).toBe result

  describe "single frame", ->

    it "should display an empty rolls list", ->
      testDisplay [], ""
        
    it "should display a single pin roll", ->
      testDisplay [4], "4"
      testDisplay [5], "5"

    it "should display a gutterball", ->
      testDisplay [0], "-"

    it "should display a strike", ->
      testDisplay [10], " X"

    it "should display an open frame", ->
      testDisplay [4,5], "45"
      testDisplay [1,2], "12"
      testDisplay [0,0], "--"
      
    it "should display a spare", ->
      testDisplay [5,5], "5/"

  describe "two frames", ->
    it "should display two open frames", ->
      testDisplay [0,0,0,0], "----"
    it "should display a spare and single pin", ->
      testDisplay [5,5,5], "5/5"
    it "should display a strike and single pin", ->
      testDisplay [10,4], " X4"

  describe "tenth frame", ->
    it "should not insert spaces before X in 10th frame strikes", ->
      testDisplay [1..12].map(->10), " X X X X X X X X XXXX"
    it "should handle gutter spare in 10th correctly", ->
      testDisplay [10,10,10,10,10,10,10,10,10, 0, 10, 5],
        " X X X X X X X X X-/5"
    it "should handle strike then spare", ->
      testDisplay [10,10,10,10,10,10,10,10,10,10, 5, 5],
        " X X X X X X X X XX5/"
    it "should handle spare then strike", ->
      testDisplay [10,10,10,10,10,10,10,10,10, 5, 5,10],
        " X X X X X X X X X5/X"


  describe "complete games", ->
    it "should display a perfect game", ->
      testDisplay [1..12].map(->10), " X X X X X X X X XXXX"
    it "should display a 150 spare game", ->
      testDisplay [1..21].map(->5), "5/5/5/5/5/5/5/5/5/5/5"
    it "should display a gutter game", ->
      testDisplay [1..20].map(->0), "--------------------"

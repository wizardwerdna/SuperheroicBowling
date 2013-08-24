'use strict'

describe 'Filter: frameScores', () ->

  # load the filter's module
  beforeEach module 'bowlingApp'

  # initialize a new instance of the filter before each test
  frameScores = {}
  beforeEach inject ($filter) ->
    frameScores = $filter 'frameScores'

  testScore = (rolls, result) ->
    (expect frameScores rolls).toEqual result

  describe "should score an incomplete frames", ->
    it "should score a single non-strike roll", ->
      testScore [], []
      testScore [3], []
    it "should score a naked spare", ->
      testScore [5,5], []
    it "should score a naked strike", ->
      testScore [10], []
    it "should score a strike w/1 roll", ->
      testScore [10, 1], []

  describe "should score a single complete frame", ->
    it "should score an open frame", ->
      testScore [0,1], [1]
      testScore [0,0], [0]

    it "should score a spare w/1 roll",->
      testScore [5,5,5], [15]

    it "should score a strike w/spare", ->
      testScore [10, 5, 5], [20]

    it "should score a turkey", ->
      testScore [10,10,10], [30]

  describe "should score two complete frames", ->
    it "should score two open frames", ->
      testScore [0,0,0,0], [0, 0]
    it "should score a spare and open frame", ->
      testScore [5,5,0,0], [10, 10]
    it "should score a strike and open frame", ->
      testScore [10, 0,0], [10, 10]

  describe "should score complete games", ->
    it "should score a perfect game", ->
      testScore [1..12].map(->10), [1..10].map (f)->30*f

    it "should score a 150 spare game", ->
      testScore [1..21].map(->5), [1..10].map (f)->15*f

    it "should score a gutter game", ->
      testScore [1..20].map(->0), [1..10].map ->0

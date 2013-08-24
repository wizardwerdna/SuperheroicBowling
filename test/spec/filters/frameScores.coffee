'use strict'

describe 'Filter: frameScores', () ->

  # load the filter's module
  beforeEach module 'bowlingApp'

  # initialize a new instance of the filter before each test
  frameScores = {}
  beforeEach inject ($filter) ->
    frameScores = $filter 'frameScores'


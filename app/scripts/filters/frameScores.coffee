'use strict';

angular.module('bowlingApp')
  .filter 'frameScores', () ->
    (rolls) ->
      (new FrameScorer rolls).frameScore()

class FrameScorer
  constructor: (@rolls)->

  frameScore: (scores=[], here=0)->
    if @isIncompleteFrame(here)
      scores
    else if @isSpare(here)
      @pushThisScoreAndFinish scores, @sumNextThreePins(here), here+2
    else if @isStrike(here)
      @pushThisScoreAndFinish scores, @sumNextThreePins(here), here+1
    else
      @pushThisScoreAndFinish scores, @sumNextTwoPins(here), here+2

  pushThisScoreAndFinish: (scores, thisFrameScore, nextFrameStart)->
      scores.push @lastScore(scores) + thisFrameScore
      @frameScore scores, nextFrameStart

  isStrike: (here)-> @rolls[here]==10

  isSpare: (here)-> @rolls[here]+@rolls[here+1]==10 and not @isStrike(here)

  sumNextThreePins: (here)-> @rolls[here]+@rolls[here+1]+@rolls[here+2]

  sumNextTwoPins: (here)-> @rolls[here]+@rolls[here+1]

  lastScore: (scores)-> scores[scores.length-1] ? 0

  isIncompleteFrame: (here)->
    @isShortFrameOrNakedStrike(here) or @isNakedSpareOrStrikeWith1Roll(here)

  isNakedSpareOrStrikeWith1Roll: (here)->
    (@rolls.length == here+2 and (@isStrike(here) or @isSpare(here)))

  isShortFrameOrNakedStrike: (here)->
    @rolls.length <= here+1 

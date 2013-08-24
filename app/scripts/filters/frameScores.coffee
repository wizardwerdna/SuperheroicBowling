'use strict';

angular.module('bowlingApp')
  .filter 'frameScores', () ->
    (rolls) ->
      if rolls.length <=1
        []
      else
        [rolls[0]+rolls[1]]

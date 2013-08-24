'use strict'

angular.module('bowlingApp')
  .filter 'rollDisplay', () ->
    (rolls) -> (new RollDisplayer rolls).rollDisplay()

class RollDisplayer
  constructor: (@rolls)->

  rollDisplay: (str="", here=0)->
    if @rolls.length == here
      str
    else if @rolls.length == here+1 and not @isStrike(here)
      str + @displayPins(here)
    else if @isStrike(here)
      @rollDisplay str + @spaceUnlessTenth(str) + "X", here+1
    else if @isSpare(here)
      @rollDisplay str + @displayPins(here) + '/', here+2
    else
      @rollDisplay str + @displayPins(here) + @displayPins(here+1), here+2

  displayPins: (here) ->
    "-123456789"[@rolls[here]] ? '?'

  isStrike: (here)-> @rolls[here]==10
  
  isSpare: (here)-> @rolls[here]+@rolls[here+1]==10 and not @isStrike(here)

  spaceUnlessTenth: (str) -> if str.length >= 18 then "" else " "

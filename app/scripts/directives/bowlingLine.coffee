'use strict'

angular.module('bowlingApp').directive 'bowlingLine', () ->
    templateUrl: 'views/bowlingLine.html'
    restrict: 'EA'
    scope: {}
    controller: 'BowlingLineCtrl'
    link: (scope, element, attrs) ->

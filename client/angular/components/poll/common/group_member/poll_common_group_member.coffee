Records        = require 'shared/services/records'
Session        = require 'shared/services/session'
AbilityService = require 'shared/services/ability_service'
EventBus       = require 'shared/services/event_bus'

{ registerKeyEvent }  = require 'shared/helpers/keyboard'
{ fieldFromTemplate } = require 'shared/helpers/poll'

angular.module('loomioApp').directive 'pollCommonGroupMember', ->
  #scope: {poll: '='}
  templateUrl: 'generated/components/poll/common/group_member/poll_common_group_member.html'
  controller: ['$scope', ($scope) ->
    $scope.fetchedMembers = false
    if $scope.poll.additionalData.apd_data1
      $scope.selectablegroupid = $scope.poll.main_group_id
    else
      $scope.selectablegroupid = $scope.poll.groupId
    $scope.fetchGroupMembers = ->
      Records.groups.fetchChildGroups($scope.selectablegroupid).then (members) ->
        if members.status == 200
          $scope.recordGroupMembers = members.members
        else
          $scope.recordGroupMembers = []
        #$scope.recordGroups = {"demo":1,"value":2}
        $scope.fetchedMembers = true

    $scope.fetchGroupMembers()

    $scope.get_data = (member_id) ->
      $scope.poll.additionalData.user_id = member_id
  ]
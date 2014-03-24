emailer.factory('GroupMember', ['$resource', function($resource) {
  return $resource('/groups/:groupId/members/:memberId',
    {
      groupId:'@groupId',
      recipientId: '@recipientId'
    }
  )
}])

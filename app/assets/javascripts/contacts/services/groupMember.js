emailer.factory('GroupMember', ['$resource', function($resource) {
  return $resource('/api/v1/groups/:groupId/members/:memberId',
    {
      groupId:'@groupId',
      recipientId: '@recipientId'
    }
  )
}])

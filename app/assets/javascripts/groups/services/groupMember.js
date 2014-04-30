groups.factory('GroupMember', ['$resource', function($resource) {
  return $resource('/api/v1/groups/:groupId/members/:id',
    {
      groupId:'@groupId',
      recipientId: '@recipientId',
      id: '@id'
    }, {
      update: {method: 'PATCH'},
    }
  )
}])

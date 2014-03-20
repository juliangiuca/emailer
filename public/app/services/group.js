emailer.factory('Group', ['$resource', function($resource) {
  return $resource('/groups/:groupId',
    {groupId:'@id'},
    {
      update: {method: 'PATCH'},
    }
  )
}])

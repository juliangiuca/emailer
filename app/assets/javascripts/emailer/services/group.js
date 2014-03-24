emailer.factory('Group', ['$resource', function($resource) {
  return $resource('/groups/:groupId',
    {
      groupId:'@id',
      emailId:'@emailId'
    },
    {
      update: {method: 'PATCH'},
      addToEmail: {method: 'POST', url: "/emails/:emailId/groups/:groupId"}
    }
  )
}])

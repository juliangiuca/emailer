groups.factory('Group', ['$resource', function($resource) {
  return $resource('/api/v1/groups/:groupId',
    {
      groupId:'@id',
      emailId:'@emailId'
    },
    {
      update: {method: 'PATCH'},
      addToEmail: {method: 'POST', url: "/api/v1/emails/:emailId/recipients/?groupId=:groupId"}
    }
  )
}])

emailer.factory('Email', ['$resource', function($resource) {
  return $resource('/api/v1/emails/:emailId',
    {emailId:'@id'},
    {
      deliver: {method: 'POST', url: "/api/v1/emails/:emailId/deliver"},
    }
  )
}])

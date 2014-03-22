emailer.factory('Contact', ['$resource', function($resource) {
  return $resource('/contacts/:contactId',
    {
      contactId:'@id'
    },
    {
      update: {method: 'PATCH'},
      addToEmail: {method: 'POST', url: "/emails/:emailId/recipients/:contactId"}
    }
  )
}])

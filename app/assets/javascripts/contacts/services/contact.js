contacts.factory('Contact', ['$resource', function($resource) {
  return $resource('/api/v1/contacts/:contactId',
    {
      contactId:'@id'
    },
    {
      update: {method: 'PATCH'},
      addToEmail: {method: 'POST', url: "/api/v1/emails/:emailId/recipients?contactId=:contactId"}
    }
  )
}])

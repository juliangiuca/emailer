emailer.factory('Contact', ['$resource', function($resource) {
  return $resource('/contacts/:contactId', 
    {contactId:'@id'},
    {update: {method: 'PATCH'}}
  )
}])

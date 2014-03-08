emailer.factory('Email', ['$resource', function($resource) {
  return $resource('/emails/:emailId', 
    {emailId:'@id'},
    {update: {method: 'PATCH'}}
  )
}])

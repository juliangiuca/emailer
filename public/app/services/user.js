emailer.factory('User', ['$resource', function($resource) {
  return $resource('/users/:userId', 
    {campaignId:'@id'},
    {update: {method: 'PATCH'}}
  )
}])

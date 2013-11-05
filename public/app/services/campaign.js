emailer.factory('Campaign', ['$resource', function($resource){
  return $resource('/campaigns/:campaignId', 
    {campaignId:'@id'},
    {
      update: {method: 'PATCH'},
      deliver: {method: 'POST', url: "/campaigns/:campaignId/deliver"},
    }
  )
}]);

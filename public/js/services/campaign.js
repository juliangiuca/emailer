emailer.factory('Campaign', ['$resource',
  function($resource){
    return $resource('campaigns.json', {}, {
      query: {method:'GET', params:{}, isArray:true}
    });
  }]
);

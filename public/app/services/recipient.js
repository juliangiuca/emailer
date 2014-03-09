emailer.factory('Recipient', ['$resource', function($resource) {
  return $resource('/emails/:emailId/recipients/:recipientId', 
    {
      emailId:'@emailId',
      recipientId:'@recipientId',
    },
    {update: {method: 'PATCH'}}
  )
}])

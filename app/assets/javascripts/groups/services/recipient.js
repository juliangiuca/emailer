groups.factory('Recipient', ['$resource', function($resource) {
  return $resource('/api/v1/emails/:emailId/recipients/:recipientId',
    {
      emailId:'@emailId',
      recipientId:'@recipientId',
      emailAddress:'@emailAddress'
    },
    {
      update: {method: 'PATCH'},
      addToEmail: {method: 'POST', url: "/api/v1/emails/:emailId/recipients?emailAddress=:emailAddress"}
    }
  )
}])

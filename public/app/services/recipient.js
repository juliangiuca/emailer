emailer.factory('Recipient', ['$resource', function($resource) {
  return $resource('/emails/:emailId/recipients/:recipientId',
    {
      emailId:'@emailId',
      recipientId:'@recipientId',
      emailAddress:'@emailAddress'
    },
    {
      update: {method: 'PATCH'},
      addToEmail: {method: 'POST', url: "/emails/:emailId/recipients?email=:emailAddress"}
    }
  )
}])

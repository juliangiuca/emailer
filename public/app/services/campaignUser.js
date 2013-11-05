emailer.factory('CampaignUser', ['$resource', function($resource) {
  return $resource('/campaigns/:campaignId/users/:userId',
    {campaignId:'@campaignId', userId:'@id'}
  )
}])


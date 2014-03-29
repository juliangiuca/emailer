function AuthenticationInterceptor($q){
  return {
    // optional method
    'request': function(config) {
      // do something on success
      return config || $q.when(config);
    },

    // optional method
    'requestError': function(rejection) {
      // do something on error
      if (canRecover(rejection)) {
        return responseOrNewPromise
      }
      return $q.reject(rejection);
    },

    // optional method
    'response': function(response) {
      // do something on success
      return response || $q.when(response);
    },

    // optional method
    'responseError': function(rejection) {
      document.location = "/"
      // do something on error
      //if (canRecover(rejection)) {
        //return responseOrNewPromise
      //}
      return $q.reject(rejection);
    }
  };
};

emailer.service('AuthenticationInterceptor', ['$q', AuthenticationInterceptor]);

function AuthenticationInterceptorConfig($httpProvider) {
  $httpProvider.interceptors.push('AuthenticationInterceptor');
}

emailer.config(['$httpProvider', AuthenticationInterceptorConfig]);

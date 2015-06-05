// GroupInput Ionic Mobile App
// Built by Andrew Arpasi

var app = angular.module('groupinput', ['ionic'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      StatusBar.styleDefault();
    }
  });
})
.controller('AudiencesCtrl', function($scope,$http) {
  //window.localStorage['audiences'] = "[]"; //Uncomment to empty audience storage
  window.localStorage['audience'] = "";
  if(!window.localStorage['audiences'])
  {
    window.localStorage['audiences'] = "[]";
  }
  else
  {
    	$scope.audiences = JSON.parse(window.localStorage['audiences']);
      console.log($scope.audiences);
  }
  
  if(!window.localStorage['token'])
  {
    $http.post('http://104.236.247.202/clients/').
        success(function(response) {
          console.log(response);
          window.localStorage['token'] = response;
        });
  }
  else
  {
    console.log("the user's token: " + window.localStorage['token']);
  }
  /*$http.get('http://104.236.247.202/registerclient/').
        success(function(response) {
          console.log("register response:" + response);
            $http.get('http://104.236.247.202/getclient/').
              success(function(response) {
                console.log("check session response:" + response);
              });
        });*/      
        
  $scope.formData = {};
  $scope.test = "hi";
  $scope.audienceName = "Loading...";
  $scope.thename = window.localStorage['name'];
  $scope.getAudienceFromCode = function(code){
    if(code){
      $http.get('http://104.236.247.202/audiencefromcode/' + code + "/" + window.localStorage['token'] + "/").
        success(function(response) {
          console.log(response);
          if(response === "error")
          {
            console.log("failed to add");
            alert("Invalid code entered.");
          }
          else if(response != null)
          {
            $scope.audiences.push(response);
            window.localStorage['audiences'] = JSON.stringify($scope.audiences);
          }
          else
          {
            alert("Invalid code entered.");
          }
          
        });
    }else{
      alert("No code entered.");
      return;
    }
  }
})

.controller('QuestionCtrl', function($scope,$http,$stateParams) {
  $scope.currentAudience = [];
  window.localStorage['audience'] = $stateParams.code;
  console.log("Local storage audience={" + window.localStorage['audience'] + "}");
    if($stateParams.code){
      $http.get('http://104.236.247.202/audiencefromcode/' + $stateParams.code + "/" + window.localStorage['token'] + "/").
        success(function(response) {
          $scope.currentAudience = response;
        });
    }else{
      alert("No code entered.");
    }
    
    //SOCKET
      
})

.config(function($stateProvider, $urlRouterProvider) {
    $stateProvider.state('home', {
      url: '/',
      templateUrl: 'home.html',
    });
    $stateProvider.state('question', {
      url: '/question/:code',
      templateUrl: 'question.html',
    });
    $urlRouterProvider.otherwise('/');
});
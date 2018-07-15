angular.module('main', [])
	.controller('mainCtrl', ['$scope', '$http', '$interval', function($scope, $http, $interval) {
		var t = $interval(function() {
			$http.get("http://localhost:4567/json").then(function(res,status,xhr) {
				console.log(res.data);
                $scope.toots = res.data;
            });
		}, 3000);
		$scope.onclick = function(){
		}
	}]);

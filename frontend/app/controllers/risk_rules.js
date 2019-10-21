module.exports = function ($scope, $http) {
  $scope.message = "Hello risk rule";

  $scope.showMessage = function() {
    alert($scope.message);
  };

}

module.exports = function ($scope, $http) {
  $scope.message = "Hello risk";

  $scope.showMessage = function() {
    alert($scope.message);
  };
}

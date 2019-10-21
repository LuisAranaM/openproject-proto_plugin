var app = angular.module('openproject');

app.controller('KittensController', ['$scope', '$http', require('./controllers/kittens.js')]);
app.controller('RisksController', ['$scope', '$http', require('./controllers/risks.js')]);
app.controller('RiskRulesController', ['$scope', '$http', require('./controllers/risk_rules.js')]);

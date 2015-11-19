angular.module("tunnel", ["ngSanitize", 'countTo'])
    .controller("TunnelController", function($scope, $http) {
        var tunnel = this;
        tunnel.ramp = ["南港", "石碇", "坪林", "頭城"];
        tunnel.start = "南港";
        tunnel.destination = "頭城";
        tunnel.currentEstimateTime = "...";
        tunnel.currentEstimateTimeOld = "0";

        var line = [[]];
        var color = ["#F44336", "#E91E63", "#9C27B0", "#673AB7", "#3F51B5", "#2196F3", "#03A9F4", "#00BCD4", "#009688", "#4CAF50", "#4CAF50", "#4CAF50", "#8BC34A"];
        var speedColor = [];
        var speeds = [];

        // get map data
        $(document).ready(function() {

        color.reverse();

        $.getJSON('http://140.115.26.21/restful/current/monitor_status/', function(data) {
                tunnel.mapData = data;
                tunnel.mapDirection = 'S';
                $.each(data,function(index, value){
                    var name = value.name.split("-");
                    if (name[1].charAt(1) == tunnel.mapDirection) {
                        /*var serial = parseInt(text[3]);
                        if ( serial >= 1.072 && serial <= 3.178) {
                            line[0].push(value.addr);
                        } else if (serial >= 9.326 && serial <= 12.945) {
                            line[1].push(value.addr);
                        } else if (serial >= 15.478 && serial <= 28.236) {
                            line[2].push(value.addr);
                        }*/
                        if (line[line.length - 1].length > 6) {
                            var meanSpeed = 0;
                            speedColor.push(color[0]);
                            $.each(speeds, function(key, speed) {
                                meanSpeed += parseInt(speed);
                            });
                            meanSpeed = meanSpeed / speeds.length;

                            if (meanSpeed > 90) {
                                speedColor[speedColor.length - 1] = color[0];
                            } else if (meanSpeed < 20) {
                                speedColor[speedColor.length - 1] = color[color.length - 1];
                            } else if (meanSpeed == -1) {
                                speedColor[speedColor.length - 1] = "white";
                            } else {
                                var index = meanSpeed / color.length;
                                index = parseInt(index);
                                speedColor[speedColor.length - 1] = color[index];
                            }

                            speeds = [];
                            line.push([]);
                        }
                        line[line.length - 1].push(value.addr);
                        speeds.push(value.speed);
                    }
                });
                var polyline = [];
                $.each(line, function(index, value) {
                    polyline.push({
                        'coords': value,
                        'color' : speedColor[index],
                        'width': 7,
                        'opacity': 1
                    });
                });
                $('#map').tinyMap({
                    'center': ['24.951796', '121.711217'],
                    'zoom'  : 11,
                    'polyline' : polyline
                });
            });
        });

        tunnel.forecastCategory = [ "現在", "15分鐘後", "30分鐘後", "60分鐘後", "120分鐘後"];
        tunnel.forecastWay = "現在";

        // get time
        $.getJSON('http://140.115.26.21/restful/current/start/' + tunnel.start + '/destination/' + tunnel.destination, function(data) {
            tunnel.currentEstimateTime = parseInt(data.time);
            $scope.$apply();
        });

        $.getJSON('http://140.115.26.21/restful/current/overall', function(data) {
            tunnel.overall = data;
            $scope.$apply();
        });

        $.getJSON('http://140.115.26.21/restful/forecast/overall', function(data) {
            tunnel.forecast = data;
            $scope.$apply();
        });

        tunnel.changeSelection = function() {
            if (tunnel.destination == tunnel.start) {
                tunnel.currentEstimateTime = 0;
            } else {
                var index = tunnel.forecastCategory.indexOf(tunnel.forecastWay);
                var forecastCategory = [15, 30, 60, 120];
                tunnel.currentEstimateTimeOld = tunnel.currentEstimateTime;
                tunnel.currentEstimateTime = "...";

                if (index) {
                    $.getJSON('http://140.115.26.21/restful/forecast/' + forecastCategory[index - 1] + '/start/' + tunnel.start + '/destination/' + tunnel.destination, function(data) {
                        tunnel.currentEstimateTime = parseInt(data.time)
                        $scope.$apply();
                    });
                } else {
                    $.getJSON('http://140.115.26.21/restful/current/start/' + tunnel.start + '/destination/' + tunnel.destination, function(data) {
                        tunnel.currentEstimateTime = parseInt(data.time);
                        $scope.$apply();
                    });
                }
            }
        }

        tunnel.exchangeSelection = function() {
            var originalStart = tunnel.start;
            tunnel.start = tunnel.destination;
            tunnel.destination = originalStart;
            tunnel.changeSelection();
        }

        tunnel.changeMapDirection = function() {
            if (tunnel.mapDirection == 'S') {
                tunnel.mapDirection = 'N';
                $("#mapInfo").html("目前顯示北上");
                $("#changeDirectionButton").html("顯示南下");
            } else {
                tunnel.mapDirection = 'S';
                $("#mapInfo").html("目前顯示南下");
                $("#changeDirectionButton").html("顯示北上");
            }
            $("#map").tinyMap('clear', 'polyline');
            line = [[]];
            speedColor = [];
            speeds = [];

            $.each(tunnel.mapData, function(index, value){
                var name = value.name.split("-");
                if (name[1].charAt(1) == tunnel.mapDirection) {
                    
                    if (line[line.length - 1].length > 6) {
                        var meanSpeed = 0;
                        speedColor.push(color[0]);
                        $.each(speeds, function(key, speed) {
                            meanSpeed += parseInt(speed);
                        });
                        meanSpeed = meanSpeed / speeds.length;

                        if (meanSpeed > 90) {
                            speedColor[speedColor.length - 1] = color[0];
                        } else if (meanSpeed < 20) {
                            speedColor[speedColor.length - 1] = color[color.length - 1];
                        } else if (meanSpeed == -1) {
                            speedColor[speedColor.length - 1] = "white";
                        } else {
                            var index = meanSpeed / color.length;
                            index = parseInt(index);
                            speedColor[speedColor.length - 1] = color[index];
                        }

                        speeds = [];
                        line.push([]);
                    }
                    line[line.length - 1].push(value.addr);
                    speeds.push(value.speed);
                }
            });
            polyline = [];
            $.each(line, function(index, value) {
                polyline.push({
                    'coords': value,
                    'color' : speedColor[index],
                    'width': 7,
                    'opacity': 1
                });
            });
            $('#map').tinyMap('modify', {
                'center': ['24.951796', '121.711217'],
                'zoom'  : 11,
                'polyline' : polyline
            });
        }
    });
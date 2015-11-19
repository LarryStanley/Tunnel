@extends("default")

@section("title")
	雪山隧道及時狀況
@stop

@section("content")
	<div class="container" ng-controller="TunnelController as tunnel">
		<h1>總覽</h1>
		<div class="row" style="" id="info">
			<div class="col-md-4 col-xs-12">
				<div class="well">
					<h2 style="color: #4CAF50">建議</h2>
					<hr>
					<p style="font-size: 18px;">
						目前塞車狀況嚴重<br>建議過20分鐘後再考慮上交流道
					</p>
				</div>
			</div>
			<div class="col-md-4 col-xs-12">
				<div class="well">
					<h2 style="color: #009688">前往時間</h2>
					<hr>
					<div class="row">
						<div class="col-md-5 col-xs-5">
							<div class="form-group">
								<select name="" id="" class="form-control" style="font-size: 18px;" ng-change="tunnel.changeSelection()" ng-model="tunnel.start">
									<option ng-repeat="ramp in tunnel.ramp"><?php echo "{{ ramp }}";?></option>
								</select>
							</div>
							到 
							<button class="btn btn-material-blue-500" style="padding: 5px 10px 5px 10px" ng-click="tunnel.exchangeSelection()">
								<i class="fa fa-arrows-v"></i>
							</button>
							<div class="form-group">
								<select name="" id="" class="form-control" style="font-size: 18px;" ng-change="tunnel.changeSelection()" ng-model="tunnel.destination">
									<option ng-repeat="ramp in tunnel.ramp"><?php echo "{{ ramp }}";?></option>
								</select>
							</div>
						</div>
						<div class="col-md-7 col-xs-7" styley="text-align: center; vertical-align:middle">
							<number count-to="<?php echo '{{ tunnel.currentEstimateTime }}'; ?>" value="<?php echo '{{ tunnel.currentEstimateTimeOld }}'; ?>" duration="1">
							</number>
							分鐘
							<select name="" id="" class="form-control" style="font-size: 18px;" ng-change="tunnel.changeSelection()" ng-model="tunnel.forecastWay">
								<option ng-repeat="category in tunnel.forecastCategory"><?php echo "{{ category }}";?></option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="well">
					<h2 style="color: #3F51B5">未來預估</h2>
					<table class="table">
						<thead>
							<tr>
								<td></td>
								<td>北上</td>
								<td>南下</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>十五分鐘</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.fifteen.north }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.fifteen.south }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
							</tr>
							<tr>
								<td>三十分鐘</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.thirty.north }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.thirty.south }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
							</tr>
							<tr>
								<td>一小時</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.sixty.north }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.sixty.south }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
							</tr>
							<tr>
								<td>兩小時</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.twohour.north }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
								<td>
									<span class="smallNumber" count-to="<?php echo "{{ tunnel.forecast.twohour.south }}";?>" value="0" duration="1"></span> 
									km/hr
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-xs-12" style="">
				<div class="well">
					<h2 style="color: #00BCD4">目前狀況</h2>
					<hr>
					<h3>總路段狀況</h3>
					<div class="row">
						<div class="col-md-6 col-sm-6">
							<div class="row speed">
								<div class="col-md-6 col-sm-6 col-xs-6">
									<number count-to="<?php echo "{{ tunnel.overall.overall.north }}";?>" value="0" duration="1"></number>
								</div>
								<div class="col-md-6 col-sm-6 col-xs-6 speedUnit">
									km/hr<br>
									北上
								</div>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="row speed">
								<div class="col-md-6 col-xs-6">
									<number count-to="<?php echo "{{ tunnel.overall.overall.south }}";?>" value="0" duration="1"></number>
								</div>
								<div class="col-md-6 col-xs-6 speedUnit">
									km/hr<br>
									南下
								</div>
							</div>
						</div>
					</div>
					<hr>	
					<h3>雪隧狀況</h3>
					<div class="row">
						<div class="col-md-6 col-sm-6">
							<div class="row speed">
								<div class="col-md-6 col-sm-6 col-xs-6">
									<number count-to="<?php echo "{{ tunnel.overall.tunnel.north }}";?>" value="0" duration="1"></number>
								</div>
								<div class="col-md-6 col-sm-6 col-xs-6 speedUnit">
									km/hr<br>
									北上
								</div>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="row speed">
								<div class="col-md-6 col-xs-6">
									<number count-to="<?php echo "{{ tunnel.overall.tunnel.south }}";?>" value="0" duration="1"></number>
								</div>
								<div class="col-md-6 col-xs-6 speedUnit">
									km/hr<br>
									南下
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-8 col-xs-12">
				<div class="well">
					<h2 style="color: #FF5722">即時路況圖</h2>
					<hr>
					<div id="map">
						
					</div>
					<div id="speedColor"></div>
					<p>
						<span>< 20 km/hr</span>
						<span class="pull-right">> 90 km/hr</span>
					</p>
					<p>
						<span id="mapInfo">目前顯示南下</span>
						<button class="btn btn-material-orange-500" id="changeDirectionButton" style="color: white" ng-click="tunnel.changeMapDirection()">
							顯示北上
						</button>
					</p>
				</div>
			</div>
		</div>
	</div>
@stop
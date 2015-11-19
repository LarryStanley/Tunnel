<!DOCTYPE html>
<html lang="zh-Hant-TW" ng-app="tunnel">
<head>
	<meta charset="UTF-8">
	<meta name="_token" content="{!! csrf_token() !!}"/>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

	<title>
		@yield("title")
	</title>

	<script>
		!function(e){"use strict";e.loadCSS=function(t,n,o){var r,i=e.document,l=i.createElement("link");if(n)r=n;else{var d=(i.body||i.getElementsByTagName("head")[0]).childNodes;r=d[d.length-1]}var a=i.styleSheets;l.rel="stylesheet",l.href=t,l.media="only x",r.parentNode.insertBefore(l,n?r:r.nextSibling);var f=function(e){for(var t=l.href,n=a.length;n--;)if(a[n].href===t)return e();setTimeout(function(){f(e)})};return l.onloadcssdefined=f,f(function(){l.media=o||"all"}),l},"undefined"!=typeof module&&(module.exports=e.loadCSS)}(this);
		loadCSS('https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css');
		loadCSS('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-design/0.3.0/css/material-fullpalette.min.css');
		loadCSS('https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css');
		loadCSS('/css/main.css');
	</script>
	
	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="/js/jquery.tinyMap-3.3.8.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.3/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.3/angular-sanitize.js"></script>
	<script src="/js/count-to.js"></script>
	<script src="/js/main.js"></script>

	@yield("head")

</head>
<body>
	@yield("content")

	<div id="fb-root"></div>
	<script>(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v2.4&appId=647423881978026";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
</body>
</html>
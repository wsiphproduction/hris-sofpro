const mix = require('laravel-mix');

mix.js('assets/resources/js/app.js', 'assets/js')
	.sass('assets/resources/sass/app.scss', 'assets/css')
	.disableNotifications()
	.copy('node_modules/bootstrap/dist/css','assets/vendor/bootstrap/css')
	.copy('node_modules/bootstrap/dist/js','assets/vendor/bootstrap/js')
	.options({
      	processCssUrls: false
   	});
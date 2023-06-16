const express 		= require('express');
const app 			= express();
const bodyParser 	= require('body-parser');
const passport 		= require('passport');
const session 		= require('express-session');
const validator 	= require('express-validator');
const cookieParser 	= require('cookie-parser');
const flash 		= require('express-flash');
const fs  			= require('fs');
const path 			= require('path');
const csrf          = require('csurf');
const morgan        = require('morgan');
const { handleError, ErrorHandler } = require('./app/Helper/error')
const ejs 			= require('express-ejs-extend');
const minifyHTML 	= require('express-minify-html');
const $env 			= require('dotenv').config();
const middleware    = require('./app/Middleware/appMiddleware');
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);

// const https 	= require('https');
// var options = {
// 	key: fs.readFileSync('./ssl/server.key'),
// 	cert: fs.readFileSync('./ssl/server.crt'),
// 	ca: fs.readFileSync('./ssl/server.ca')
// };
	
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cookieParser());
app.use(csrf({ cookie: true }));
app.use(session({
    saveUninitialized: true,
    resave: true,
    secret: '6YCQwZKX2csc8NxYRsTt7UbBeR59PNdM'
}));

//Flash Message
app.use(flash());

//Express Validator
app.use(validator());

/*
|---------------------------------------------------------
| ENGINE
|---------------------------------------------------------
*/
app.engine('ejs', ejs);
app.set('view engine','ejs');
app.set('views', path.join(__dirname, 'app/View/'));
/*
|---------------------------------------------------------
| MINIFY HTML
|---------------------------------------------------------
*/
app.use(minifyHTML({
    override: true,
    exception_url: false,
    htmlMinifier: {
        removeComments: true,
        collapseWhitespace: false,
        collapseBooleanAttributes: true,
        removeAttributeQuotes: false,
        removeEmptyAttributes: true,
        minifyJS: true
    }
}));
/*
|---------------------------------------------------------
| Public Directory
|---------------------------------------------------------
*/
app.use(express.static(path.join(__dirname, 'assets')));

/*
|---------------------------------------------------------
| Auth Middleware
|---------------------------------------------------------
*/
// function guard(req, res, next) {
// 	const users = require('./app/Models/Global');
// 	let count = users.count();
// 	if(count.count){
// 		if($env.parsed.APP_ENV == 'production' && !req.session.user){
// 			res.render('Auth/login');
// 		}else{
// 			return next();
// 		}
// 	}else{
// 		res.render('Install/register');
// 	}
// }

app.use(middleware.initialize);


if($env.parsed.APP_ENV != 'production'){
	app.use(morgan('dev'));
}

//app.use(morgan('common'));
require('./app/routes/web.js')(app, middleware.countUser, csrf);
require('./app/Scheduler/jobs.js');

//Error Handler
app.use((err, req, res, next) => {
    handleError(err, res);
});

app.use((req, res) => {
  res.render('Errors/404');
});

var port = process.env.PORT || $env.parsed.APP_PORT;
app.listen(port, function(){
  	console.log('Magic happens on *:' + port);
});


# My Gulpfile
gulp         = require 'gulp'
gutil        = require 'gulp-util'
plumber      = require 'gulp-plumber'
concat       = require 'gulp-concat'
minifyHTML   = require 'gulp-minify-html'
sass         = require 'gulp-ruby-sass'
sourcemaps   = require 'gulp-sourcemaps'
autoprefixer = require 'gulp-autoprefixer'
nano         = require 'gulp-cssnano'
coffee       = require 'gulp-coffee'
uglify       = require 'gulp-uglify'
imagemin     = require 'gulp-imagemin'
pngquant     = require 'imagemin-pngquant'

gulp.task 'html', ->
	gulp.src './src/**/*.html'
	.pipe minifyHTML()
	.pipe gulp.dest './'

gulp.task 'css', ->
	sass('./src/scss', {sourcemap: true, style: 'expanded'}).on 'error', gutil.log
	.pipe autoprefixer browsers: 'last 2 versions', cascade: false
	.pipe nano()
	.pipe sourcemaps.write './maps', sourceRoot: '../../src/scss'
	.pipe gulp.dest './css'

gulp.task 'js', ->
	gulp.src './src/coffeescript/*.coffee'
	.pipe sourcemaps.init()
	.pipe plumber()
	.pipe coffee(bare: true).on 'error', gutil.log
	.pipe uglify()
	.pipe sourcemaps.write './maps', sourceRoot: '../../src/coffeescript'
	.pipe gulp.dest './js'

gulp.task 'img', ->
	gulp.src 'src/images/**/*.*'
	.pipe imagemin(progresive = true, use: pngquant(), multipass: true, optimizationLevel: 7)
	.pipe gulp.dest './img'

gulp.task 'watch', ->
	gulp.watch 'src/**/*.html', ['html']
	gulp.watch 'src/scss/**/*.scss', ['css']
	gulp.watch 'src/coffeescript/**/*.coffee', ['js']
	gulp.watch 'src/images/**/*.*', ['img']

gulp.task 'default', ['html', 'css', 'js', 'img', 'watch']


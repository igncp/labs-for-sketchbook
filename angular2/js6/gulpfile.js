// Some parts are from: https://github.com/SekibOmazic/angular2-playground

var gulp = require('gulp');
var del = require('del');
var plumber = require('gulp-plumber');
var rename = require('gulp-rename');
var traceur = require('gulp-traceur');
var shell = require('gulp-shell');
var runSequence = require('run-sequence');


var PATHS = {
    src: {
        js: 'src/**/*.js',
        html: 'src/**/*.html',
        angular: "../repositories/angular/modules/angular2/**/*.ts"
    },
    lib: [
        '../node_modules/gulp-traceur/node_modules/traceur/bin/traceur-runtime.js',
        '../node_modules/es6-module-loader/dist/es6-module-loader-sans-promises.src.js',
        '../node_modules/systemjs/lib/extension-register.js',
        '../node_modules/zone.js/dist/zone.js',
        '../node_modules/zone.js/dist/long-stack-trace-zone.js',
        '../node_modules/reflect-metadata/Reflect.js',
        '../node_modules/reflect-metadata/Reflect.js.map'
    ]
};

gulp.task('clean', function(done) {
    del(['dist'], done);
});

gulp.task('js', function() {
    return gulp.src(PATHS.src.js)
        .pipe(rename({
            extname: ''
        })) //hack, see: https://github.com/sindresorhus/gulp-traceur/issues/54
        .pipe(plumber())
        .pipe(traceur({
            modules: 'instantiate',
            moduleName: true,
            annotations: true,
            types: true,
            memberVariables: true
        }))
        .pipe(rename({
            extname: '.js'
        })) //hack, see: https://github.com/sindresorhus/gulp-traceur/issues/54
        .pipe(gulp.dest('dist'));
});

gulp.task('html', function() {
    return gulp.src(PATHS.src.html)
        .pipe(gulp.dest('dist'));
});

gulp.task('libs', ['angular2'], function() {
    var size = require('gulp-size');
    return gulp.src(PATHS.lib)
        .pipe(size({
            showFiles: true,
            gzip: true
        }))
        .pipe(gulp.dest('dist/lib'));
});

gulp.task('angular2', function() {
    var buildConfig = {
        paths: {
            "angular2/*": "../../repositories/angular/dist/js/dev/es6/angular2/*.js",
            "rx": "../node_modules/rx/dist/rx.js"
        },
        meta: {
            // auto-detection fails to detect properly here - https://github.com/systemjs/builder/issues/123
            'rx': {
                format: 'cjs'
            }
        }
    };

    var Builder = require('systemjs-builder');
    var builder = new Builder(buildConfig);

    builder.build('angular2/angular2', 'dist/lib/angular2.js', {});
});

gulp.task('run', ['js', 'html', 'libs']);
gulp.task('default', ['run']);

gulp.task('build-angular', function(done) {
    gulp.src('../gulpfile.js').pipe(shell([
        'cd ../../../; gulp build.js.dev; exit'
    ])).on('end', done);
});

gulp.task('run-and-serve', ['run'], function() {
    var http = require('http');
    var connect = require('connect');
    var serveStatic = require('serve-static');
    var port = 9000,
        app;

    gulp.watch(PATHS.src.html, ['html']);
    gulp.watch(PATHS.src.js, ['js']);
    gulp.watch(PATHS.src.angular, function() {
        runSequence('build-angular', 'libs');
    });

    app = connect().use(serveStatic(process.cwd() + '/dist'));
    http.createServer(app).listen(port);
});

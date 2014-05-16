var gulp = require('gulp');
var source = require('vinyl-source-stream');
var browserify = require('browserify');
var glob = require('glob');

var paths = {
  scripts: "./test/**/*.js"
}

gulp.task('scripts', function() {
    var testFiles = glob.sync('./test/**/*.js');
    var bundleStream = browserify(testFiles).bundle({debug: true});
    return bundleStream
        .pipe(source('bundle-tests.js'))
        .pipe(gulp.dest('compiled_tests'));
});

gulp.task('watch', function() {
  gulp.watch(paths.scripts, ['scripts']);
  //gulp.watch(paths.images, ['images']);
});

gulp.task('default', ['scripts', 'watch']);

const gulp = require('gulp');
const gp_rename = require('gulp-rename');
const gp_concat = require('gulp-concat');
const gp_ugligy = require('gulp-uglify');
const gp_minify  = require('gulp-minify');

exports.default = () => {
    return gulp.src('../js/*.js')
        .pipe(gp_concat('concat.js'))
        .pipe(gp_ugligy())
        .pipe(gp_minify())
        .pipe(gp_rename('app-min.js'))
        .pipe(gulp.dest("../js/bundle/"));
}
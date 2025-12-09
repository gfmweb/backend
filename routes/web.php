<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('health', function () {
    return response(['ok']);
});

Route::get('test', function () {
    return response(['ok_test_more']);
});

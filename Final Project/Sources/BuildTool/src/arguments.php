<?php

return [
    'help' => [
        'prefix'      => 'h',
        'longPrefix'  => 'help',
        'description' => 'Prints a usage statement',
        'noValue'     => true,
    ],

    'path' => [
        'description' => 'The path with SQL files to be processed',
        'required'    => true,
    ],

    'up' => [
        'description' => 'The path to save UP script',
        'required'    => true,
    ],

    'down' => [
        'description' => 'The path to save DOWN script',
        'required'    => true,
    ],
];
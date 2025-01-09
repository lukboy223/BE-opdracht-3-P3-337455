<?php

//function that logs errors that occur in the try-catch block.

function logger($line, $method, $file, $error)
{

    //the error.
    $error = 'The error is:' . $error . "\t";

    //time of the error.
    date_default_timezone_set('Europe/Amsterdam');
    $dateTime = 'Date/Time:' . date('d-m-Y H:i:s', time()) . "\t";

    //ip address of the user who got the error.
    $remote_ip = 'Remote IP-Address: ' . $_SERVER['REMOTE_ADDR'] . "\t";

    //file name of the error.
    $filename = "Filename: " . $file . "\t";

    //method name of the error
    $methodname = 'Methodname: ' . $method . "\t";

    //line
    $lineNumber = 'Line number: ' . $line . "\t";

    //puts all information in single variable
    $content = $dateTime . $remote_ip . $error . $filename . $methodname . $lineNumber . "\r";

    //path to log file.
    $pathToLogFile = APPROOT . '/logs/log.txt';

    //checks if file exists.
    if(!file_exists($pathToLogFile)){
        file_put_contents($pathToLogFile, "- Non functional Log\r \r");
    }

    //writes error in log file
    file_put_contents($pathToLogFile, $content, FILE_APPEND);
}

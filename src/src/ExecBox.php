<?php
/**
 * Created by PhpStorm.
 * User: matthes
 * Date: 19.01.18
 * Time: 14:14
 */

namespace Kick;


class ExecBox
{

    private $workingDir;

    public function __construct(string $workingDir)
    {
        $this->workingDir = $workingDir;
    }

    private $pids = [];

    public function runBg ($cmd)
    {
        $curDir = getcwd();
        chdir($this->workingDir);
        if (preg_match("/^D\:(.*)$/", $cmd, $matches)) {
            $cmd = $matches[1];
            Out::log("Exec in background:", $cmd);

            // Only way to do this: start commands in background and aquire pid by file
            $aPipes = [];
            $rProc = proc_open("bash -c 'trap \"kill 0\" EXIT; $cmd 2>&1 > /dev/tty & wait' & echo $! > /tmp/curpid.kick", [], $aPipes);
            proc_close($rProc);
            $this->pids[] = (int) file_get_contents("/tmp/curpid.kick");
        } else {
            Out::log("Exec syncronously:", $cmd);
            system($cmd, $ret);
            if ($ret != 0) {
                Out::fail("Command", $cmd, "returned exit-code: $ret");
                chdir($curDir);
                exit ($ret);
            }
        }
        chdir($curDir);
    }


    public function killAll ()
    {
        foreach ($this->pids as $pid) {
            Out::log("Killing $pid...");
            posix_kill($pid, SIGTERM);
        }
        $this->pids = [];
    }



}
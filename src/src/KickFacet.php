<?php
/**
 * Created by PhpStorm.
 * User: matthes
 * Date: 19.01.18
 * Time: 12:44
 */

namespace Kick;


use Symfony\Component\Yaml\Exception\ParseException;
use Symfony\Component\Yaml\Yaml;

class KickFacet
{

    const CONF_STATE_FILE = "/tmp/kick.state";

    private $workingDir;
    private $config = [];

    private $execBox;

    public function __construct(string $startYamlFileName = null)
    {
        if ($startYamlFileName === null)
            $startYamlFileName = "/opt/.kick.yml";
        $this->workingDir = dirname($startYamlFileName);
        try {
            $this->config = Yaml::parseFile($startYamlFileName);
        } catch (ParseException $e) {
            Out::fail("Error parsing '.kick.yml': " . $e->getMessage());
            throw $e;
        }

        foreach ($this->config as $key=>$value) {
            if (is_array($value))
                continue;
            putenv("KICK_" . strtoupper($key) . "=$value");
        }

        if (file_exists(self::CONF_STATE_FILE)) {
            $this->execBox = unserialize(
                file_get_contents(self::CONF_STATE_FILE)
            );
        } else {
            $this->execBox = new ExecBox($this->workingDir);
        }

    }


    public function __destruct()
    {
        file_put_contents(self::CONF_STATE_FILE, serialize($this->execBox));
    }


    public function dispatchCmd ($cmd, array $options)
    {
        switch ($cmd) {

            case "kill":
                $this->execBox->killAll();
                Out::log("Killed all background services");
                return true;

            default:
                // search for command in command: - section
                break;
        }


        if ( ! $value = access($this->config, ["command", $cmd])) {
            if (in_array($cmd, ["init", "dev", "run"])) {
                Out::warn("No command defined for '$cmd': Ignore!");
                return true;
            }
            throw new \InvalidArgumentException("Command '$cmd' not defined.");
        }
        foreach ($value as $cur) {
            Out::log("Target '$cur': ");
            $this->execBox->runBg($cur);
        }


    }


    public function dispatch(array $argv)
    {
        try {
            $call = array_shift($argv);
            $cmd = array_shift($argv);
            $this->dispatchCmd($cmd, $argv);
        } catch (\Exception $e) {
            Out::fail("Exception: " . $e->getMessage() . "");
            throw $e;
        }
    }
}
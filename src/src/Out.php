<?php
/**
 * Created by PhpStorm.
 * User: matthes
 * Date: 19.01.18
 * Time: 14:49
 */

namespace Kick;


class Out
{

    public static function log(...$args)
    {
        echo " + " . implode (" ", $args) . "\n";
    }

    public static function warn(...$args)
    {
        echo Color::Str("\n[WARN] " . implode (" ", $args), "yellow") . "\n";
    }

    public static function fail(...$args)
    {
        echo Color::Str("\n\n[ERR] ". implode (" ", $args) . "\n", "black", "red") . "\n";
    }
}
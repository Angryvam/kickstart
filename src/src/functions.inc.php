<?php


/**
 * Safely return the contents of a key of array structure
 *
 * @param       $input
 * @param array $keys
 * @param null  $default
 *
 * @return null
 */
function access ($input, array $keys, $default=null)
{
    $cur =& $input;
    foreach ($keys as $key) {
        if ( ! isset ($cur[$key]))
            return $default;
        $cur =& $cur[$key];
    }
    return $cur;
}
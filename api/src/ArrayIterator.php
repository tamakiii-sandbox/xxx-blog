<?php

namespace App;

class ArrayIterator
{
    public static function map(iterable $list, callable $function): array
    {
        $result = [];

        foreach ($list as $key => $value) {
            $result[$key] = $function($value);
        }

        return $result;
    }
}

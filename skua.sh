#!/bin/bash
d="$(dirname $0)";
code="var dir = '$d/node_modules';
      var Rx = require(dir + '/rx'),
      RxNode = require(dir + '/rx-node'),
      R = require(dir + '/ramda');
      with (R) {
        var stdin = RxNode.fromStream(process.stdin)
                          .map(String)
                          .flatMap(split('\n'))
                          .filter(length);
        stdin.$1 // Inline the provided transforms
             .map(String)
             .subscribe(console.log.bind(console));
      }"
node -e "$code"


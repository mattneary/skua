#!/bin/bash
real_dir() {
  # get the real dir of the symlinked node binary
  local path="$1"
  (cd "$(dirname $0)/$(dirname $(readlink $path))";
   echo "`pwd -P`") 2> /dev/null
}
d=$(real_dir $BASH_SOURCE)
code="var dir = '$d/node_modules';
      var Rx = require(dir + '/rx'),
          RxNode = require(dir + '/rx-node'),
          R = require(dir + '/ramda'),
          prelude = require(dir + '/../prelude');
      with (R.merge(R, prelude)) {
        // TODO: chunking makes artificial line-breaks.
        var stdin = RxNode.fromStream(process.stdin)
                          .map(String)
                          .flatMap(split('\n'))
                          .filter(length);
        stdin.$1 // Inline the provided transforms
             .map(String)
             .subscribe(console.log.bind(console));
      }"
node -e "$code"


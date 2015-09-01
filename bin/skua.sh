#!/bin/bash
real_dir() {
  # get the real dir of the symlinked node binary
  local path="$1"
  (cd "$(dirname $0)/$(dirname $(readlink $path))/..";
   echo "`pwd -P`") 2> /dev/null
}
d=$(real_dir $BASH_SOURCE)
src=`echo "$1" | $d/bin/skua-lisp`
code="var dir = '$d/node_modules';
      var Rx = require(dir + '/rx'),
          RxNode = require(dir + '/rx-node'),
          R = require(dir + '/ramda'),
          prelude = require(dir + '/../lib/prelude');
      R.keys(prelude.transforms).forEach(function (k) {
        Rx.Observable.prototype[k] = prelude.transforms[k];
      });
      with (R.merge(R, prelude.operators)) {
        // TODO: chunking makes artificial line-breaks.
        var stdin = RxNode.fromStream(process.stdin)
                          .map(String)
                          .flatMap(split('\n'))
                          .filter(length);
        stdin.$src // Inline the provided transforms
             .map(String)
             .subscribe(console.log.bind(console));
      }"
node -e "$code"


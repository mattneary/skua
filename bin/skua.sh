#!/usr/bin/env cdrepo
d=$(dirname $0)

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


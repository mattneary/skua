var R = require('ramda');
module.exports = {
  operators: {
    fanout: R.curry(function (j, f, g, x) {
      return j(f(x), g(x));
    }),
    naturalSort: R.curry(function (a, b) {
      if (a.match(/^[0-9]/) && b.match(/^[0-9]/)) {
        var leadingNumber = /^[0-9]+/;
        var nA = a.match(leadingNumber)[0],
            nB = b.match(leadingNumber)[0];
        if (nA != nB) {
          return nB - nA;
        }
      }
      return R.comparator(R.lt)(a, b);
    }),
    sandwich: R.curry(function (x, a, b) {
      return R.join(x, [a, b]);
    }),
    parse: JSON.parse,
    stringify: JSON.stringify
  }, transforms: {
    squash: function () {
      return this.toArray().map(R.join('\n'));
    },
    explode: function () {
      return this.flatMap(R.split('\n'));
    }
  }
};


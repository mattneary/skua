var R = require('ramda');
module.exports = {
  fanout: R.curry(function (j, f, g, x) {
    return j(f(x), g(x));
  }),
  naturalSort: R.comparator(R.lt),
  ALL: 1e6
};


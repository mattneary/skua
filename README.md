# skua
![skua](https://upload.wikimedia.org/wikipedia/commons/0/0d/Stercorarius_pomarinusPCCA20070623-3985B.jpg)

> Text processing in the order of awk

```sh
$ npm install -g
```

# usage

The following is an implementation of McIlroy's [famed
one-liner](http://www.leancrew.com/all-this/2011/12/more-shell-less-egg/) in
skua.

```sh
$ cat README.md | skua "flatMap(split(/[^A-Za-z]+/)) .
                        filter(test(/[A-Za-z]/)) .
                        map(toLower) .
                        bufferWithCount(ALL) .
                        map(countBy(identity)) .
                        map(fanout(zip, keys, values)) .
                        map(map(join(' '))) .
                        flatMap(sort(naturalSort))"
```


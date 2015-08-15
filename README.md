# skua
![skua](https://upload.wikimedia.org/wikipedia/commons/0/0d/Stercorarius_pomarinusPCCA20070623-3985B.jpg)

> Text processing in the order of awk

```sh
$ npm install -g skua-cli
```

# usage

The following is an implementation of McIlroy's [famed
one-liner](http://www.leancrew.com/all-this/2011/12/more-shell-less-egg/) in
skua.

```sh
$ cat README.md | skua "flatMap(split(/[^A-Za-z]/)) .
                        filter(compose(not, test(/^$/))) .
                        map(toLower) .
                        toArray() .
                        map(countBy(identity)) .
                        map(fanout(zipWith(sandwich(' ')), values, keys)) .
                        flatMap(sort(naturalSort)) .
                        take(4)"
6 skua
4 sh
3 cat
3 flatmap
```

```sh
$ cat README.md | skua "filter(test(/usage/))"
# usage
```

```sh
$ cat package.json | skua "squash() .
                           flatMap(pipe(JSON.parse, prop('dependencies'), keys))"
ramda
rx
rx-node
```


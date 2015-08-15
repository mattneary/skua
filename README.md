# skua
![skua](https://upload.wikimedia.org/wikipedia/commons/0/0d/Stercorarius_pomarinusPCCA20070623-3985B.jpg)

> Text processing in the order of awk

```sh
$ npm install -g
```

```sh
$ cat file.txt | skua "map(Number) . map(add(1))"
```


This project uses
[servant-server](http://haskell-servant.readthedocs.io/) and
[persistent](https://www.stackage.org/package/persistent) for saving data to a database.

You can build and run the project with [stack](http://haskellstack.org/), e.g.:

```shell
stack build
stack exec YEGNightOutBackend
```

Then you can query the server from a separate shell:

```shell
curl -H 'Content-type: application/json' localhost:3000/user --data '{"name": "Alice", "age": 42}'
curl -H 'Content-type: application/json' localhost:3000/user/Alice
```

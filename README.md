## Develop

```sh
cat .env.example > .env
```

```sh
direnv allow
```

```sh
cargo lambda watch
```

```sh
cargo lambda invoke application --data-ascii '{}'
```

### Extension

```sh
cargo run -p extension
```

## Deploy

### Application

```sh
cargo lambda build
```

```sh
cargo lambda deploy
```

### Extension

```sh
cargo lambda build --extension
```

```sh
cargo lambda deploy --extension
```

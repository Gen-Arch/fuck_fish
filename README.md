# fuck fish
fuck fish WebAPI
fooooooooo!!!!!

### mongo-express
http://localhost:4567/mongodb

## graphql
http://localhost:4567/mongodb/graphql

# Deplotment
- [Ruby(2.5.0)](https://www.ruby-lang.org/ja/)
- [Graphql](https://graphql.org/)
- [Graphql-ruby](https://graphql-ruby.org/)
- [sinatra](http://sinatrarb.com/)

## DB
- [mongodb](https://www.mongodb.com/)
- [mongoid](https://docs.mongodb.com/mongoid/current/)



# Usage

## install
```
bundle install
```


## create systemd file(.service&.target)
```
bundle exec procsd create
```

## start
```
bundle exec procsd start
```

## stop
```
bundle exec procsd stop
```


## restart
```
bundle exec procsd restart
```

## enable service
```
bundle exec procsd enable
```

# debug

## systemd status
```
bundle exec procsd status
```

## systemd log
```
bundle exec procsd logs
```

## command list
```
Commands:
  procsd --version, -v   # Print the version
  procsd config          # Print config files based on current settings. Available types: sudoers
  procsd create          # Create and enable app services
  procsd destroy         # Stop, disable and remove app services
  procsd disable         # Disable app target
  procsd enable          # Enable app target
  procsd exec            # Run app process
  procsd help [COMMAND]  # Describe available commands or one specific command
  procsd list            # List all app services
  procsd logs            # Show app services logs
  procsd restart         # Restart app services
  procsd start           # Start app services
  procsd status          # Show app services status
  procsd stop            # Stop app services
```

# http Request

## all reqest
```
curl -H "Content-Type: application/json" -X POST "http://localhost:4567/mongodb/graphql" -d '{"query": "{ diary { title text name tags } }" }' | jq
```

```
{
  "data": {
    "search": [
      {
        "title": "hogehoge",
        "text": "sample text",
        "name": "gen",
        "tags": "[\"test1\", \"test2\", \"test3\"]"
      },
      {
        "title": "hogehoge",
        "text": "sample text",
        "name": "gen",
        "tags": "[\"test1\", \"test2\", \"test3\"]"
      }
    ]
  }
}

```

## serch
```
curl -H "Content-Type: application/json" -X POST "http://localhost:4567/mongodb/graphql" -d '{"query": "{ search(name: gen2) { name } }" }' | jq
```

```
{
  "data": {
    "search": [
      {
        "name": "gen2"
      }
    ]
  }
}
```
## mutation
```
reqest
curl 'http://localhost:4567/mongodb/graphql' \
 -H 'Accept-Encoding: gzip, deflate, br' \
 -H 'Content-Type: application/json' \
 -H 'Accept: application/json' \
 -H 'Connection: keep-alive' \
 -H 'DNT: 1' \
 -H 'Origin: file://' \
 --data-binary '{"query":"mutation AddDiary(\n  $title: String!\n  $text: String!\n  $name: String!\n  $tags: [String!]!\n) {\n  createDiary(title: $title, text: $text, name: $name, tags: $tags) {\n    success\n    errors\n  }\n}\n","variables":{"title":"testhoge","text":"foooooo!!","name":"gem","tags":["aa","sss"]}}' --compressed｀｀｀
```

```
{
  "data":{
    "createDiary":{
      "success":true,
      "errors":[]
    }
  }
}
```

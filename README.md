# Service

## sinatra

### 起動
```shell:start
bundle exec puma -e [開発環境] config.ru
```

[開発環境]
* development
* production

### 停止

```shell:stop
bundle exec pumactl stop
```

## vue.js

```
cd front
npm install
npm run build
```

## elasticsearch

```
docker-compose up
```


# API
url => http://gen-server.wjg.jp/fuck_fish/elastic 

## 値追加
* /index/[type]

[type] => table名

json request: true

```shell:sample request
curl -X POST "http://gen-server.wjg.jp/fuck_fish/elastic/index/diary/" -d '
{"body": {
  "title": "hogehoge",
  "text": "sample text",
  "contributor": "gen",
  "tags": ["test1", "test2", "test3"]
  }
}
'
```

## 値削除
* /delete/[type]

[type] => table名

json request: true

```shell:sample request
curl -X POST "http://gen-server.wjg.jp/fuck_fish/elastic/delete/diary/" -d '{"id": "1"}'
```


## 検索

* /search

json request: true || false

```shell:sample request
curl -X GET "http://gen-server.wjg.jp/fuck_fish/elastic/search/"
#=> 全値取得
```

```shell:sample request
curl -X GET "http://gen-server.wjg.jp/fuck_fish/elastic/search/" -d '{"query": "hoge"}'
#=> キーワード「hoge」で全文検索
```

```shell:sample request
curl -X GET "http://gen-server.wjg.jp/fuck_fish/elastic/search/" -d '{"query": {"text": "hoge"}}'
#=> key「text」, キーワード「hoge」で全文検索
```


### response
```
{"took"=>2,
 "timed_out"=>false,
 "_shards"=>{"total"=>5, "successful"=>5, "skipped"=>0, "failed"=>0},
 "hits"=>
  {"total"=>1,
   "max_score"=>0.2876821,
   "hits"=>
    [{"_index"=>"fuck_fish",
      "_type"=>"diary",
      "_id"=>"cWpV_GcBrRcFypaTDKB4",
      "_score"=>0.2876821,
      "_source"=>
       {"title"=>"test title",
        "text"=>"hoge~~~~~~~",
        "contributor"=>"gen",
        "tags"=>["test1", "test2", "test3"]}}]}}
```
※検索結果が複数の場合、hitsに格納されてゆく
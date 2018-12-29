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

# README
歌詞の感想・解釈を共有するアプリ『ファブリリ』

https://fav-lyri.com/

## 開発言語
* Ruby 3.0.1
* Ruby on Rails 6.1.7

## 就業Termの技術
* devise
* Ajaxを使ったお気に入り機能
* Ajaxを使ったコメント機能
* Ajaxを使ったフォロー機能
* AWS(EC2)へのデプロイ

## カリキュラム外の技術
* ransack を使用した検索機能
* Active Job と whenever を使用した定期ジョブ実行
* Spotify WebAPI (rspotify) を使用した楽曲再生機能
* OpenAI API (ruby-openai) を使用した歌詞解説機能

## 実行手順

```
$ git clone git@github.com:kmikiko/original_app.git
$ cd original_app
$ bundle
$ yarn
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails s
```  

## カタログ設計, テーブル設計, ワイヤーフレーム
[カタログ設計](https://docs.google.com/spreadsheets/d/1rgskN4CPZRHm1_0nyAryxIcdYGyQ6PzMTHMbZoDAzsw/edit?hl=JA#gid=2017131208) 

[テーブル設計](https://docs.google.com/spreadsheets/d/1rgskN4CPZRHm1_0nyAryxIcdYGyQ6PzMTHMbZoDAzsw/edit?hl=JA#gid=496992112)

[ワイヤーフレーム](https://www.figma.com/file/vuSW4oWcpo730zwOtS08XB/Untitled?type=design&node-id=0-1&mode=design&t=W2ii61JIkdBxISu1-0)


## インフラ構成図
![インフラ構成図](https://github.com/kmikiko/fav-lyri/assets/127947837/3be1c5d2-233e-4db9-9b42-6955d09f1b64)


## 画面遷移図
![original_app_er-ページ2 drawio](https://github.com/kmikiko/fav-lyri/assets/127947837/e677eb0c-9d8b-4ca4-97af-9c2d6a1cdc7f)

## ER図　
![original_app_er drawio ](https://github.com/kmikiko/original_app/assets/127947837/1018875e-d37e-4095-ab75-490db610a0a1)
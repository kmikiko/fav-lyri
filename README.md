# README

## 開発言語
* Ruby 3.0.1
* Ruby on Rails 6.1.7

## 就業Termの技術
* devise
* Ajaxを使ったお気に入り機能
* Ajaxを使ったコメント機能
* フォロー機能
* AWS(EC2)へのデプロイ

## カリキュラム外の技術
* Spotify WebAPI を使用した楽曲再生機能
* ransack を使用した検索機能
* Active Job と whenever を使用した定期ジョブ実行

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

## カタログ設計, テーブル設計
https://docs.google.com/spreadsheets/d/1rgskN4CPZRHm1_0nyAryxIcdYGyQ6PzMTHMbZoDAzsw/edit?hl=JA#gid=2017131208


## ワイヤーフレーム
https://www.figma.com/file/vuSW4oWcpo730zwOtS08XB/Untitled?type=design&node-id=0-1&mode=design&t=W2ii61JIkdBxISu1-0



## 画面遷移図
![original_app画面遷移 drawio ](https://github.com/kmikiko/original_app/assets/127947837/f7acd392-22d1-4a3a-b30f-b1eead0a8599)


## ER図　
![original_app_er drawio ](https://github.com/kmikiko/original_app/assets/127947837/1018875e-d37e-4095-ab75-490db610a0a1)
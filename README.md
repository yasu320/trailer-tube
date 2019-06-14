# 概要
YouTubeAPIを利用して、取得した映画予告から映画を探したり、映画をレビューできるサイトです。  
https://trailer-tube.herokuapp.com/
# 機能一覧
* ログイン機能
* Oauth認証(twitter,facebook)
* 退会機能
* ユーザ情報編集機能
* ユーザー画像、投稿機能(Active Storage,AWS S3)
* 星評価機能(ratyrate)
* ページネーション機能
* レスポンシブデザイン対応
* i18nを用いた国際化
* テスト実装(RSpec)

# 使用している技術一覧
* Ruby 2.5.3
* Ruby on Rails 5.2.3
* PostgreSQL 9.6.10
* Heroku
* 動画取得はYouTube　APIを使用
* Bootstrap4
* ログイン機能はdeviseを使用
* twitter,facebookログインはomniauthを使用
* ページネーションにはkaminariを使用
* Active Storageを用いて、AWSのS3にアップロード
* bulletを用いてN + 1問題の解決
* rubocop-airbnbを用いてコードの整形

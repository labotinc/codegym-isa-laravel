## セットアップ手順(make を使うやり方, かんたん)

1. Makefile があるディレクトリ(リポジトリ直下)で下記のコマンドを実行する

   ```
   make init
   ```

1. laravelapp をブラウザで表示する

   - http://localhost:10480 にアクセスする

## セットアップ手順(make を使わないやり方)

1. app コンテナのユーザ ID をホスト側と合わせるためのファイル .env を作成する

   - docker-compose.yml があるディレクトリで下記のコマンドを実行する

     ```
     # `id -u` の実行結果はホストによって異なる
     echo DOCKER_UID=`id -u` > .env
     ```

1. コンテナをビルドして起動する

   - docker-compose.yml があるディレクトリで下記のコマンドを実行する

     1. 各コンテナをキャッシュを使わずにビルドする

        ```
        docker-compose build --no-cache
        ```

     1. 各コンテナをバックグラウンドで起動する
        ```
        docker-compose up -d
        ```

1. 起動中の app コンテナの bash を、app コンテナのユーザ"docker"の権限で実行する

   ```
   # appコンテナのユーザ"docker"の権限でappコンテナのbashを実行するコマンド
   docker-compose exec --user docker app bash
   ```

   - 下記のようなプロンプトに切り替わる

     ```
     docker@efba441bb520:/var/www/html/laravelapp$
     ```

1. app コンテナの bash で laravelapp を install する

   1. composer install を実行する

      ```
      docker@efba441bb520:/var/www/html/laravelapp$ composer install
      ```

   1. laravel を動作させるために必要なアクセス権を付与する

      ```
      docker@efba441bb520:/var/www/html/laravelapp$ chmod 777 -R storage bootstrap/cache
      ```

1. laravelapp をブラウザで表示する

   - http://localhost:10480 にアクセスする

## コンテナを終了する方法

- docker-compose.yml があるディレクトリで下記のコマンドを実行する

  ```
  docker-compose down
  ```

## 備考

- ホスト側で html 配下のファイルを編集すれば app コンテナに反映される
- composer コマンドや artisan コマンドは app コンテナの bash で実行する
- laravelapp は db コンテナの MySQL データベース:docker_db に接続済みである

## artisan を使う方法

- 例 1) migration を行う方法

  - app コンテナの bash で 下記のコマンドを実行する

    ```
    docker@efba441bb520:/var/www/html/laravelapp$ php artisan migrate
    ```

- 例 2) HelloController を作成する方法

  - app コンテナの bash で 下記のコマンドを実行する

    ```
    docker@efba441bb520:/var/www/html/laravelapp$ php artisan make:controller HelloController
    ```

## ブラウザで phpMyAdmin を表示する方法

- http://localhost:10481 にアクセスする

## make コマンドの解説(Makefile 参照)

- make up

  - docker コンテナを起動する

- make ps

  - docker コンテナの状態を表示する

- make down

  - docker コンテナを停止する

- make bash

  - app コンテナで ユーザ:docker の bash を起動する

- make migrate-seed

  - laravelapp のマイグレーションとシーディングを行う

- make init

  - docker コンテナのビルドから laravelapp のマイグレーションとシーディングまでを行う

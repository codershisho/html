# PHPとNode.jsを含むベースイメージを指定
FROM php:8.1-fpm

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# PHP拡張機能のインストール
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composerのインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Node.jsのインストール (LTS版を利用)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

# npmパッケージのインストール (必要に応じて、Laravel Mixなどのビルドツールを利用する場合に追加)
RUN npm install -g npm

# コンテナ内の作業ディレクトリを設定
WORKDIR /var/www/html

# Composerを使って依存パッケージをインストール
# RUN composer install

# Node.jsを使ってフロントエンドのリソースをビルド（必要に応じてコメントアウトを外す）
# RUN npm install && npm run dev

# アプリケーションキーの生成と設定
# RUN php artisan key:generate

# Nginxコンテナへの接続を待機するように設定
# CMD php artisan serve --host=0.0.0.0 --port=8000

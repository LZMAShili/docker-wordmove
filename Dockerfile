FROM ruby:alpine

LABEL maintainers="LZMAShili"

ENV WORDMOVE_WORKDIR=/html

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

COPY mount-ssh.sh /bin/mount-ssh.sh
RUN chmod +x /bin/mount-ssh.sh
RUN apk update && apk upgrade --no-cache && apk add --no-cache openssh curl rsync mariadb-client php-mysqli php-phar php-json php-mbstring lftp git ruby-dev make gcc libc-dev && gem update --system
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN gem install wordmove --pre
WORKDIR /html
ENTRYPOINT ["/bin/mount-ssh.sh"]
CMD ["/bin/ash"]

FROM ruby:alpine

LABEL maintainers="LZMAShili"

ENV WORDMOVE_WORKDIR=/html

COPY mount-ssh.sh /bin/mount-ssh.sh
RUN /bin/sh -c chmod +x /bin/mount-ssh.sh
RUN /bin/sh -c apk update && apk upgrade --no-cache && apk add --no-cache openssh-server curl rsync mariadb-client php-mysqli php-phar php-json php-mbstring lftp git ruby-dev make gcc libc-dev && gem update --system
RUN /bin/sh -c curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN /bin/sh -c gem install wordmove --pre
WORKDIR /html
ENTRYPOINT ["/bin/mount-ssh.sh"]
CMD ["/bin/ash"]

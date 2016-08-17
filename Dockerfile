FROM ruby:2.2.2

RUN curl -sSL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y nodejs \
    && apt-get -qy autoremove \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

RUN cd /opt \
    && git clone https://github.com/ConradIrwin/showterm.io

WORKDIR /opt/showterm.io

COPY resources/database.yml config/
RUN cd /opt/showterm.io \
    && bundle install \
    && bundle exec rake db:create db:migrate db:seed

EXPOSE 3000
CMD ["rails", "s"]

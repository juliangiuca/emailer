FROM ruby:2.2.1-onbuild

EXPOSE 8080

CMD rails server -p 8080 -b 0.0.0.0

web: bundle exec thin -R config.ru start -p $PORT -e $RACK_ENV
resque: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 bundle exec resque work -r ./app/jobs/jobs.rb



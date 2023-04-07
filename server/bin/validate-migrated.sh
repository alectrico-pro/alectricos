#https://phrase.com/blog/posts/unifying-rails-environments-docker-compose/
# build/validate-migrated.sh
if rake db:migrate:status &> /dev/null; then
  rake db:migrate
else
  rake db:setup
fi

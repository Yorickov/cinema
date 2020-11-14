install:
	bundle install

run:
	ruby main.rb

test:
	bundle exec rspec

push:
	git push -u origin main

.PHONY: test

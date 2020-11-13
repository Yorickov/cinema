install:
	bundle install

run:
	ruby main.rb 10

test:
	bundle exec rspec

push:
	git push -u origin master

.PHONY: test

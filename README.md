# rubyTraining

## How to start it:
```sh
git clone https://github.com/ChRomain/rubyTraining.git rubyTraining
cd rubyTraining
rails server
```
Open a browser and go in port 3000.

## Test definition:
Due to time limitation test coverage is low. Just nominal case for Article geter.
* Check title getter
* Check body getter
* Check author getter
* Check published_at getter

TODO/Improvement:
Generate allure report
Add other test about corner case, exist or not, corrupted db, load testing with multiple // call...

## GraphQl API
Once server is started open a browser and go in playground 3000/graphiql

TODO/Improvement
Block schema documentation for unauthenticated user - for secu purpose
Add pagination for query all items
Add some input validation
Add some server side batching
Take ruby naming convention (not yet known)
Check object imbrication - for now ok
Check for schema introspection blocking
Block auto completion
Tke care of alias attack
....

### Query
Query all articles
```
query {
  articles {
    id
    title
    body
    author { name email }
    publishedAt
  }
}
```

Query all articles written by a specific author
```
query {
  articlesByAuthor (authorId: "{{authorId}}") {
    body
    id
    title
  }
}
```

Query a specific article
```
query {
  article(id: "{{articleId}}") {
    id
    title
    body
    author { name email }
    publishedAt
  }
}
```

### Mutation
For now no input validation and no authentication

Create a new article - Author must exist and be valid
```
mutation {
  createArticle (
    title: "Article test",
    body: "Body test",
    authorId: "{{authorId}}",
    published_at: "2999-01-01T01:01:01Z"
  ) {
    title
  }
}
```

Update a specific article - Article id must exist and be valid
```
mutation {
  updateArticle (
    id: "{{articleId}}",
    title: "New name",
    body: "New body"
  ) {
    title
  }
}
```

Delete a specific article by his id - Article id must exist and be valid
```
mutation { deleteArticle(id: "{{articleId}}") }
```


### Subscription
None

## Import script
A rake script is present under lib/tasks/.
Aims of this script is to be able to register authors or articles throught csv file.
Those files must be placed under lib/assets folder.

If the script fail to register one author or one article it will continue to loop over the csv and print a report 
with number of error at the end.

``` shell
sudo bundle exec rake import:all
```

TODO/Improvement:
Take csv form external source.
Validate csv file: content, size for example.
Print a pretty report at the end to indicate which author/article encountered issue.

## Links:
* https://api.rubyonrails.org/
* https://guides.rubyonrails.org/getting_started.html
* https://grafikart.fr/tutoriels/premiers-pas-838#autoplay
* https://www.guru99.com/fr/ruby-on-rails-tutorial.html
* https://ai.rails-guide.com/fr/testing.html
* https://semaphoreci.com/community/tutorials/getting-started-with-rspechttps://semaphoreci.com/community/tutorials/getting-started-with-rspec
* https://www.tutorialspoint.com/rspec/rspec_basic_syntax.htm
* https://lukaszwrobel.pl/blog/rake-tutorial/
* https://www.devdungeon.com/content/ruby-rake-tutorial

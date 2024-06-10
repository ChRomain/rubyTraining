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

## GraphQl API
Once server is started open a browser and go in playground 3000/graphiql
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

## Links:
* https://api.rubyonrails.org/
* https://guides.rubyonrails.org/getting_started.html
* https://grafikart.fr/tutoriels/premiers-pas-838#autoplay
* https://www.guru99.com/fr/ruby-on-rails-tutorial.html
* https://ai.rails-guide.com/fr/testing.html
* https://semaphoreci.com/community/tutorials/getting-started-with-rspechttps://semaphoreci.com/community/tutorials/getting-started-with-rspec
* https://www.tutorialspoint.com/rspec/rspec_basic_syntax.htm

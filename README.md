# rubyTraining

## How to start it
```sh
git clone https://github.com/ChRomain/rubyTraining.git rubyTraining
cd rubyTraining
rails server
```
Open a browser and go in port **3000**.

## Routes endpoints
* /articles: List all articles.
* /articles/new: Create article form.
* /articles/:id: Query a specific article.
* /articles/:id/edit: Update a specific article.
* /articles/:id/delete: Remove specific article.

Some routes endpoints for author also available.

## Test definition
Due to time limitation test coverage is low. Just nominal case for Article geter.
* Check title getter
* Check body getter
* Check author getter
* Check published_at getter

**TODO/Improvement**:
- [ ] Generate allure report
- [ ] Add other test about corner case, exist or not, corrupted db, load testing with multiple // call...

## GraphQl API
Once server is started open a browser and go in playground 3000/graphiql

**TODO/Improvement**
- [ ] Block schema documentation for unauthenticated user - for secu purpose
- [ ] Add pagination for query all items
- [ ] Add some input validation
- [ ] Add some server side batching
- [ ] Take ruby naming convention (not yet known)
- [ ] Check object imbrication - for now ok
- [ ] Check for schema introspection blocking
- [ ] Block auto completion
- [ ] Tke care of alias attack
....

### Authentication
You will have to be authenticated in order to play with some mutation/query.
Steps:
1. Execute logIn query:
```
mutation {
    signUp (
        input: {
        email: "email@email.com"
        password: "pwd"
        role: admin
        }
    ) { email role }
}
```
2. LogIn with created user
```
mutation {
  logIn(
      input: {
        email: "email@email.com"
        password: "pwd"
      }
  ) {
    token
  }
}
```
If user exist a bearer will be prompt in output.
Copy it and for next query/mutation add it in Headers section as follow:
**{ "Authorization": "Bearer PREVIOUS_TOKEN" }**

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
For now no input validation

Create a new article - Author must exist and be valid
```
mutation {
  createArticle (
    input: {
      title: "Article test",
      body: "Body test",
      authorId: "{{authorId}}",
      published_at: "2999-01-01T01:01:01Z"
    }
  ) {
    title
  }
}
```

Update a specific article - Article id must exist and be valid
```
mutation {
  updateArticle (
    input: {
      id: "{{articleId}}",
      title: "New name",
      body: "New body"
    }
  ) {
    title
  }
}
```

Delete a specific article by his id - Article id must exist and be valid
```
mutation {
  deleteArticle (
    input: {
      id: "{{articleId}}"
    }
  )
}
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

**TODO/Improvement:**
- [ ] Take csv form external source.
- [ ] Validate csv file: content, size for example.
- [ ] Print a pretty report at the end to indicate which author/article encountered issue.

## Links
* [Ruby on Rails fundamental concepts](https://medium.com/@bhuvaneshganesan/ruby-on-rails-fundamental-concepts-a3f6b92b0127#:~:text=Ruby%20on%20Rails%20is%20a,development%20more%20straightforward%20and%20efficient)
* [The ails Command Line](https://guides.rubyonrails.org/v4.2/command_line.html)
* [Ruby on Rails Projects: Introduction for Beginners](https://www.microverse.org/blog/ruby-on-rails-projects-introduction-for-beginners#toc-string-manipulation-projects)
* [Ruby on Rails - Introduction](https://www.tutorialspoint.com/ruby-on-rails/rails-introduction.htm)
* [Ruby on Rails Tutorial for Beginners with Project & Example](https://www.guru99.com/ruby-on-rails-tutorial.html)
* [Using GraphQL with Rails 7: Building Efficient APIs](https://medium.com/simform-engineering/using-graphql-with-rails-7-building-efficient-apis-76006c14b8de)
* [Using GraphQL with Ruby on Rails](https://www.apollographql.com/blog/using-graphql-with-ruby-on-rails)
* [Doc Ruby](https://api.rubyonrails.org/)
* [RailsGuides](https://guides.rubyonrails.org/getting_started.html)
* [Set of tuto video on ruby on rails project](https://grafikart.fr/tutoriels/premiers-pas-838#autoplay)
* [Tutorial Ruby on Rails pour débutants avec projet et exemple](https://www.guru99.com/fr/ruby-on-rails-tutorial.html)
* [Tester les applications Rails](https://ai.rails-guide.com/fr/testing.html)
* [RSpec - Basic syntax](https://www.tutorialspoint.com/rspec/rspec_basic_syntax.htm)
* [Rake tutorial](https://lukaszwrobel.pl/blog/rake-tutorial/)
* [Ruby Rake Tutorial](https://www.devdungeon.com/content/ruby-rake-tutorial)
* [Rails Authentication with BCrypt & JWT, made simple and clear](https://medium.com/@brandon.lau86/rails-authentication-with-bcrypt-jwt-made-simple-and-clear-9268c116043f)
* A lot of stack overflow

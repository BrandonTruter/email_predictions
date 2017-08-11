# Email Predictor


Simple app which evaluates patterns based on various filters then returns possible email predictions

Command line:

```shell
$ ruby ./predict.rb  "FirstName Surname" "domain.com"
```

Ruby:

```ruby
# predict.rb
require 'email_predictor'

EmailPredictor.new("FirstName Surname", "test.com")
```

    
********************************


## Rack application

Provides a basic search [UI](https://mysterious-hollows-18448.herokuapp.com) form for
   predicting email addresses using name and domain filters:

Run by starting up rack with: 

```shell
$ rackup 
```

View at: [http://localhost:9292](http://localhost:9292)

Available endpoints:
  
['/'](https://mysterious-hollows-18448.herokuapp.com/)
['/search'](https://mysterious-hollows-18448.herokuapp.com/search)
['/anything_else'](https://mysterious-hollows-18448.herokuapp.com/anything_else)

  
********************************


## Command line

  
  ~> Provides basic commands to predicts emails patterns from ARGS options passed to file

  ~> Predictions are based on 'name' & 'domain' args 
    
  ~> Offers flags such as '--all' & '--test' for various types of predictions
          
  ~> Within the Terminal, using the following command as demonstration for example usage:
  

```ruby
# predict.rb

$ ruby ./predict.rb  "FirstName Surname" "domain.com"
```


### Usage

There are 2 types of possible predictions:

1. Using flags

2. Using arguments


All Predictions:

Returns a list of all predictions

```shell
$ ruby ./predict.rb -a
$ ruby ./predict.rb --all
```

Default Predictions:

Returns predictions based on default requirements

```shell
$ ruby ./predict.rb -d
$ ruby ./predict.rb --default
```

Filtered Predictions:

Predictions based on arguments passed:
  > First argument is the desired full name
  > Second argument is domain (...@email_domain)

```shell
$ ruby ./predict.rb  "FirstName Surname" "domain.com"
```

```shell
$ ruby ./predict.rb  "FirstName Surname" "apple.com"
```

Generated output is based on patterns from existing advisors

For example, passing the following arguments:

```shell
$ ruby ./predict.rb "FirstName Surname" "google.com"
```

Returns 2 predictions based on existing 'google.com' patterns:
  

```ruby
      ........ FirstName Surname ; google.com ........
    ....................................................
                firstname.s@google.com
                 f.surname@google.com
```

********************************

## Getting Started


Clone the repository:
 
```shell
$ git clone https://github.com/BrandonTruter/email_predictions.git
```

Navigate to project:
 
```shell
$ cd email_predictions
```

Install dependencies:

```shell
$ bundle
```


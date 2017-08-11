# Email Predictor


Simple app which evaluates patterns based on various filters then returns possible email predictions

Command line:
```shell
$ ruby ./predict.rb  "FirstName Surname" "domain.com"
```

Ruby:
```ruby
# email_predictor.rb
require 'email_predictor'

EmailPredictor.new("FirstName Surname", "test.com")
```

    
********************************


## Rack application

A basic search [UI](https://mysterious-hollows-18448.herokuapp.com) form for
   predicting email addresses using name and domain filters:


### Usage

Start up rack: 
```shell
$ rackup 
```

View at: [http://localhost:9292](http://localhost:9292)

Available paths:

[ROOT](https://mysterious-hollows-18448.herokuapp.com/)

[SEARCH](hhttps://mysterious-hollows-18448.herokuapp.com/search)

[ERRORS](https://mysterious-hollows-18448.herokuapp.com/anything_else)

  
********************************


## Command line

A ruby file which provides a set of commands to predict possible email addresses


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

> Predictions based on passed arguments 

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

Outputs:
```ruby
      ........ FirstName Surname ; google.com ........
    ....................................................
                firstname.s@google.com
                 f.surname@google.com
```

Returns 2 predictions based on all existing 'google.com' patterns:


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


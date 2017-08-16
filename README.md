# Email Predictor

<<<<<<< HEAD

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
=======
Simple app which evaluates patterns based on various filters then returns possible email predictions

________________________________________________________________________________

## Getting Started

Clone the repository:
```shell
$ git clone https://github.com/BrandonTruter/email_predictions.git
```
>>>>>>> github/develop

Navigate to project:
```shell
$ cd email_predictions
```

Install dependencies:
```shell
$ bundle
```

<<<<<<< HEAD
### Usage

Start up rack: 
```shell
$ rackup 
```

View at: [http://localhost:9292](http://localhost:9292)

Available endpoints:

> ROOT path ['/'](https://mysterious-hollows-18448.herokuapp.com/)
> SEARCH path['/search'](https://mysterious-hollows-18448.herokuapp.com/search)
> ERRORS path ['/anything_else'](https://mysterious-hollows-18448.herokuapp.com/anything_else)
=======
>>>>>>> github/develop

  
********************************

## Usage

<<<<<<< HEAD
## Command line

A ruby file which provides a set of commands to predict possible email addresses


### Usage

There are 2 types of possible predictions:
  1. Using flags
  2. Using arguments
=======

### Ruby

Ruby:
```ruby
# email_predictor.rb
require 'email_predictor'

EmailPredictor.new("FirstName Surname", "test.com")
```

>>>>>>> github/develop

### Command line

<<<<<<< HEAD
#### Default Predictions:

> Returns predictions based on defaults (-d & --default)

```shell
$ ruby ./predict.rb --default
```

#### All Predictions:

> Returns a list of all predictions (-a & --all)

```shell
$ ruby ./predict.rb 
```

#### Filtered Predictions:

> Predictions based on passed arguments 

$ ruby ./predict.rb  "FirstName Surname" "domain.com"

$ ruby ./predict.rb  "FirstName Surname" "apple.com"


Generated output is based on patterns from existing advisors

For example, passing the following arguments:
```shell
$ ruby ./predict.rb "FirstName Surname" "google.com"
```

Outputs:
```shell
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
=======
Set of commands to determine patterns of possible email address predictions


#### Filtered Predictions:

Returns predictions based on arguments 

```shell
$ ruby ./predict.rb "FirstName Surname" "domain.com"

$ ruby ./predict.rb "FirstName Surname" "apple.com"

$ ruby ./predict.rb "FirstName Surname" "google.com"
```

#### Default Predictions:

Returns predictions based on default requirements

```shell
$ ruby ./predict.rb -d
$ ruby ./predict.rb --default
```

#### All Predictions:

Returns a list of all possible predictions

```shell
$ ruby ./predict.rb -a
$ ruby ./predict.rb --all
```


### Browser

A basic rack application with UI to search [UI](https://mysterious-hollows-18448.herokuapp.com) for predicting email addresses using name and domain filters:


Start up rack: 
```shell
$ rackup 
```

View at: [http://localhost:9292](http://localhost:9292)


>>>>>>> github/develop


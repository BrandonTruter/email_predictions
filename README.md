# Email Predictor

Simple app which evaluates patterns based on various filters then returns possible email predictions

________________________________________________________________________________

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

  
********************************

## Usage


### Ruby

```ruby
require './email_predictor'

EmailPredictor.new("FirstName Surname", "google.com")
```

### Command line

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




 git push github HEAD:master

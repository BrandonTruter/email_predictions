# Email Predictor

    Email prediction app to determine patterns and generate possible predictions


********************************


## Rack application

  ~> A simple rack app to provide a form for entering name & domain for email predictions:

  ~> Start the rack server using following command then open the link in a browser:
  
    $ rackup 
  
    > Visit http://localhost:9292
      Search Form: '/' or '/search'
      Error Form: '/anything_else'
  

===========================================================================================

## Command line
  
  ~> Provides basic commands to predicts emails patterns from ARGS options passed to file

  ~> Predictions are based on 'name' & 'domain' args 
    
  ~> Offers flags such as '--all' & '--test' for various types of predictions
          
  ~> Within the Terminal, using the following command as demonstration for example usage:
  
    ```
      $ ruby ./predict.rb  "FirstName Surname" "google.com"
    ```
  
  Output:
      
    ........ FirstName Surname ; google.com ........
    ....................................................
    
      firstname.s@google.com
      f.surname@google.com


  Explanation: Generate 2 predictions because of the following 2 existing google accounts:
                >  larry.p@google.com
                >  s.brin@google.com


********************************

## Getting Started


### Installation

  1. Setup repository:

        $ git clone https://git.heroku.com/mysterious-hollows-18448.git email_predictor

        $ cd email_predictor
      
  2. Run dependencies:      

        $ bundle


### Usage

  1. Using the command line via ruby scripts:
  
      $ ruby ./predict.rb  "FirstName Surname" "sovtech.com"
      $ ruby ./predict_all.rb  "FirstName Surname" "sovtech.com"
      
      => predict.rb
      => lib/email_predictor.rb
      
      
  2. Using the browser via UI rack app:
  
      $ rackup
      
      > http://localhost:9292/
      > http://localhost:9292/search

      => /config.ru
      => /email_predictor.rb


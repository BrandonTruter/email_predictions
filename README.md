
# Email Predictor

********************************

##  Description

  Simple command_line app using patterns to predict advisor email addresseses.
  
  Also contains a simple rack app to provide a form for making predictions via UI.
      /config.ru
      /lib/email_prediction_app.rb

===========================================================================================


## USAGE  (_Rack App_)

  Within the Terminal, running the app with the following command:
  
  $ rackup
  
  > Visit http://localhost:9292/


## USAGE  (_Command line_)

  Within the Terminal, using the following command:

  $ ruby ./predict.rb  "FirstName Surname" "google.com"

        ........ FirstName Surname ; google.com ........
        ....................................................

          firstname.s@google.com
          f.surname@google.com


  Predicts email patterns based on ARGS options passed to file.

  Example shows 2 predictions because of the following 2 existing google accounts:
        >  larry.p@google.com
        >  s.brin@google.com

===========================================================================================

  $ ruby ./predict_all.rb  "FirstName Surname" "gmail.com"

        >  firstname.surname@gmail.com
        >  firstname.s@gmail.com
        >  f.surname@gmail.com
        >  f.s@gmail.com

    Always returns 4-pattern predictions based on provided ARGS.
        TODO: To be merged into code as a fallback for predictions that can't be made. 

===========================================================================================

  > Displays predictions based on 'name' and 'domain' args
    
  > Using flags to display various types of predictions, such as the '--all' or '-a' flags: 
          $ ruby ./email_predictor.rb -a
          $ ruby ./email_predictor.rb --all 


===========================================================================================

## Getting Started

  1. Setup repository:

      $ git clone ........

      
  2. Run dependencies:
  
      $ cd email-predictor/
      
      $ bundle


  3. Run Required Commands as mentioned above:

      $ ruby ./predict.rb  "FirstName Surname" "google.com"
      
      ,,,
      
      $ rackup
      


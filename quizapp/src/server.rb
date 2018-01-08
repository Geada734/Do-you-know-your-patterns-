#Final Project: Design Patterns Quiz App
# Date: 23-November-2017
# Authors:
#          A01168958 Francisco Geada Rodríguez 
#          A01373179 María Fernanda Cruz González

#Main server for the application
require 'sinatra'
require './models/questionaire_manager'

#Setting up Sinatra
set :bind, '0.0.0.0'
set :port, ENV['PORT']
enable :sessions
set :session_secret, 'SecretString#!$%'

#GET method called when the application is initialized
#It takes the user to the homepage
get '/' do
    erb :index
end

#Method called after the user has selected the number of questions they wish to 
#answer
#It takes the users to the quiz
post '/' do
    #This number is posted by Quiz.erb through a collapsable menu and a submit button
    session[:number]=params[:number]
    #Set to 0 by default, nobody gets a headstart
    session[:score]=0
    #This variable keeps track of which question the user is on
    session[:counter]=1
    #A new "Questionaire_Manager" object is created to manage the quiz
    manager=Questionaire_Manager.new params[:number].to_i
    #The questionaire is set from the number of questions taken from the last post
    manager.genQuestionaire
    session[:questionaire]=manager.questions
    #Users are taken to the quiz
    redirect '/quiz'
end

#GET method for the quiz layout
get '/quiz' do
    #"counter" and "number" variables taken from previous post
    @counter=session[:counter]
    @number=session[:number]
    #List of questions to be used
    @questionaire=session[:questionaire]
    
    erb :quiz
end

#POST method for the quiz page called after the user chooses an answer and submits it
post '/quiz' do
    #The counter variable is incremented
    session[:counter]+=1
    #The score is increased if the answer was correct, oterwise, 0 is added
    #to the current score
    session[:score]=session[:score]+params[:correct].to_i
    #If the quiz is over, the user is taken to the results page
    if session[:counter]>session[:number].to_i
        redirect'/results'
    #Otherwise, a new question is displayed using the "quiz" layout
    else
        redirect'/quiz'
    end
end

#GET method for the results layout
get '/results' do
    #The obtained score is displayed out of the number of questions chosen
    @score=session[:score]
    @number=session[:number]
    erb :results
end

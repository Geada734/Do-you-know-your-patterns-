#Final Project: Design Patterns Quiz App
# Date: 23-November-2017
# Authors:
#          A01168958 Francisco Geada Rodríguez 
#          A01373179 María Fernanda Cruz González

#This class creates the questionaire for each quiz
require 'sequel'
require './models/question'

class Questionaire_Manager 
  #Class is initialized
  attr_accessor :number, :questions
  #Method that initializes the lass
  def initialize n
    #Number of questions for this quiz
    @number=n
    #Questions that are going to be used
    @questions=[]
    #Connection to the database from where the questions are going to be taken
    @DB=Sequel.connect("sqlite://./models/questions.db")
  end
  
  #Generate the questionaire and scrambles available questions
  def genQuestionaire
    #Table "questions" from the database through instance variable "roster"
    roster=@DB[:questions]
    #Limit for the iterator that will generate the list of questions
    lim=@number-1
    #Space available
    available=[]
    #This iterator stores the whole database in the "available" variable
    #in the form of several "Question" objects
    (1..40).each do |index|
      #Paramters for the "Question" class are set
      #Question text
      q=roster.first(id: index)[:question].to_s
      #Answer a
      a=roster.first(id: index)[:answerA].to_s
      #Answer b
      b=roster.first(id: index)[:answerB].to_s
      #Answer c
      c=roster.first(id: index)[:answerC].to_s
      #Correct answer
      corr=roster.first(id: index)[:correct].to_s
      #Questions are built
      available.push Question.new q, a, b, c, corr
    end
    
    #The "available" variable is randomized and stored in the "scrambled" variable
    scrambled=available.shuffle
    
    #This iterator takes the number of questions specified by the users and stores 
    #them in the final questionaire
    (0..lim).each do |question|
      @questions.push scrambled[question]
    end
    puts 
  end
  
end



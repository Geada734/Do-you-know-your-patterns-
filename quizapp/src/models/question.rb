#Final Project: Design Patterns Quiz App
# Date: 23-November-2017
# Authors:
#          A01168958 Francisco Geada Rodríguez 
#          A01373179 María Fernanda Cruz González

#Class for each individual multiple question
class Question
  #Class is initialized
  attr_accessor :question, :answerA, :answerB, :answerC, :correct
  #Initializing the class
  def initialize q, a, b, c, corr
    #Question text
    @question=q
    #Answer a
    @answerA=a
    #Answer b
    @answerB=b
    #Answer c
    @answerC=c
    #Correct answer
    @correct=corr
  end
end

#Final Project: Design Patterns Quiz App
# Date: 23-November-2017
# Authors:
#          A01168958 Francisco Geada Rodríguez 
#          A01373179 María Fernanda Cruz González

#Script in charge of creating the Sequel database where the questions are taken from
#This ruby script is only executed once
require 'json'
require './question'
require 'sequel'

#Questions are taken from a JSON file called "questions.js"
jsonSource=JSON.parse(File.read('./questions.json'))

#The database is created as the file "questions.db in the "models" folder"
DB = Sequel.connect("sqlite://questions.db")

#This table mirrors the Question ruby class but has the id attribute for easy
#management
DB.create_table :questions do
  #Database id
  primary_key :id
  #The question
  String :question, uniq: true, null: false
  #Answer a
  String :answerA, uniq: true, null: false
  #Answer b
  String :answerB, uniq: true, null: false
  #Answer c
  String :answerC, uniq: true, null: false
  #Correct answer
  String :correct, uniq: true, null: false
end

#We call the "questions" table as the "roster variable"
roster=DB[:questions]

#We insert each question directly from the JSON file into the table
jsonSource["questions"].each do |q|
  roster.insert(id: q["id"], question: q["question"], answerA: q["answerA"], answerB: q["answerB"], answerC: q["answerC"], correct: q["correct"])
end


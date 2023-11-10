//
//  Exercise.swift
//  
//
//  Created by Andrew Thayer on 11/10/23.
//

import Foundation

struct Exercise{
  var name: String
  //this is an array of strings
  var muscleGroups: [String]
  var reps: Int
  var sets: Int
  var totalReps: Int

  init(name: String, muscleGroups:[String], reps: Int, sets: Int){
    self.name = name
    self.muscleGroups = muscleGroups
    self.reps = reps
    self.sets = sets
    self.totalReps = reps * sets
  }

}

//Test example
var pushUp = Exercise(name: "Push Up", muscleGroups:["Triceps", "Chest", "Shoulders"], reps: 10, sets: 3)

//print(pushUp)

struct Regimen{
  var dayOfWeek: String
  //This is an array of Exercises
  var exercises: [Exercise]

  init(dayOfWeek: String, exercises: [Exercise]){
    self.dayOfWeek = dayOfWeek
    self.exercises = exercises
  }

  func printExercisePlan(){
    print("Today is \(dayOfWeek) and the plan is to:")
    //loops through exercises array printing pattern of exercise info
    for exercise in self.exercises{
      print("Do \(exercise.sets) sets of \(exercise.reps) \(exercise.name)s")

      print("That's a total of \(exercise.totalReps) \(exercise.name)s")
    }
  }
}

var mondayRegimen = Regimen(dayOfWeek: "Monday", exercises: [pushUp])

//mondayRegimen.printExercisePlan()

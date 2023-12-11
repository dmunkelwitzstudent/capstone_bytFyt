//
//  ActiveView.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/16/23.
//

import SwiftUI
import SwiftData


struct ActiveView: View {
    
    // The following statements will set up the modelContext and queries for us to manipulate
    @Environment(\.modelContext) private var modelContext;
    @Query private var users: [User];
    @Query private var workouts: [Workout];
    
    
    struct AppColorScheme {
        static let backgroundColor = Color.red
        static let accentColor = Color.white
        static let textColor = Color.white
    }
    
    // Variables used to edit the selected workout
    @State var workoutName: String = "";
    @State var workoutCalories: String = "";
    @State var muscleGroup: String = "";
    @State var desc: String = "";
    
    // Used to display errors
    @State var showAlert: Bool = false;
    @State var alertMsg: String = "";
    
    
    var body: some View {
        
        let main = users[0];
        
        ZStack {
            AppColorScheme.backgroundColor
                .ignoresSafeArea(edges: .all)
            
            
            VStack {
                // Sleep Tracker Header
                Text("Activity Tracker")
                    .font(.largeTitle)
                    .foregroundColor(AppColorScheme.textColor)
                    .padding()
                    .background(AppColorScheme.backgroundColor)
                
                //Displays progress for currentActiveCaloruies to goal
                ProgressView(value: Double(Double(main.currentActiveCalories) / Double(main.ActivityGoal))) {
                    
                }
                .accentColor(Color.white)
                Text("\(main.currentActiveCalories, specifier: "%.0f") Calories out of \(main.ActivityGoal, specifier: "%.0f") Goal")
                    .foregroundStyle(AppColorScheme.textColor)
                
                
                Spacer()
                
                // Sleep Metrics
                VStack(alignment: .center, spacing: 200) {
                    
                    
                    // Set up a Navigation view, with a list representing all workouts inside the database.
                    // user can create a new workout with the plus button, and delete them by swiping.
                    NavigationSplitView {
                        
                        List {
                            
                            ForEach (workouts) { workout in
                                
                                NavigationLink {
                                    
                                    // To say if user completed a workout that day
                                    Button("Completed Workout") {
                                        if (main.currentActiveCalories + workout.TotalCalories > 5000) {
                                            main.currentActiveCalories = 5000;
                                        } else {
                                            main.currentActiveCalories += workout.TotalCalories;
                                        }
                                        
                                    }
                                    
                                    // Displaying current workout information
                                    VStack {
                                        Text("Workout: \(workout.Name)")
                                            .font(.title)
                                        Text("Total Calories: \(workout.TotalCalories, specifier: "%.0f")")
                                            .font(.title2)
                                        
                                        //Text("Workout Description: \(workout.Desc)")
                                        Text("Muscle Group: \(workout.MuscleGroup)")
                                            .font(.title3)
                                            .padding()
                                        Text("Description")
                                            .font(.title3)
                                        Divider()
                                        Text("\(workout.Desc)")
                                    } .frame(width: 400, alignment: .center)
                                    
                                    Divider()
                                        .padding()
                                    // button to confirm changes
                                    Button("Edit Workout") {
                                        
                                        
                                        if (workoutName != "") {
                                            workout.Name = workoutName;
                                        }
                                        
                                        if (muscleGroup != "") {
                                            workout.MuscleGroup = muscleGroup;
                                        }
                                        if (desc != "") {
                                            workout.Desc = desc;
                                        }
                                        
                                        // validating number
                                        if let newCalories = Double(workoutCalories) {
                                            
                                            
                                            if (newCalories > 0 && newCalories <= 5000) {
                                                workout.TotalCalories = newCalories;
                                            } else {
                                                showAlert = true;
                                                alertMsg = "Please enter a calorie count between 0 and 5000";
                                            }
                                            
                                            
                                            
                                        } else {
                                            showAlert = true;
                                            alertMsg = "Please enter a valid calorie count";
                                        }
                                        
                                        workoutName = "";
                                        workoutCalories = "";
                                        muscleGroup = "";
                                        desc = "";
                                        
                                    }.alert(alertMsg, isPresented: $showAlert) {
                                        Button("OK", role: .cancel) {
                                            showAlert = false;
                                            alertMsg = "";
                                        }

                                    }
                                    // for editing workout information
                                    VStack {
                                        TextField("Workout: Name", text: $workoutName)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        TextField("Workout: Total Calories", text: $workoutCalories)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        TextField("Workout: Muscle Group", text: $muscleGroup)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        TextField("Workout: Description", text: $desc)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                    } .frame(width: 250, alignment: .center)
                                    
                                    
                                    
                                } label: {
                                    Text("\(workout.Name)");
                                    
                                }
                            }
                            .onDelete(perform: deleteWorkout)
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
                            ToolbarItem {
                                Button(action: addWorkout) {
                                    Label("Add Item", systemImage: "plus")
                                }
                            }
                        }
                        
                    } detail: {
                        Text("Select an item")
                    }
                    
                    
                    
                    
                }
            }
        }
    }
    private func addWorkout() {
        // pushing new workout into modelContext
        var newWorkout = Workout.init(name: "Default #\(workouts.count + 1)");
        modelContext.insert(newWorkout)
    }
    
    private func deleteWorkout(offsets: IndexSet) {
        // deleting workout from modelContext
        for index in offsets {
            modelContext.delete(workouts[index])
        }
    }
}

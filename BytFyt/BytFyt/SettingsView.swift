//
//  SettingsView.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 12/3/23.
//

import SwiftUI
import SwiftData



struct SettingsView: View {
    
    
    // Very similar to the initial login, used to change data if user made a mistake
    // or changed their height.
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User];
    @State var activityLevel: Double = 1.15;
    
    @State var showAlert = false
    
    @State var alertMsg = "";
    
    @State var unitMessage = "in";
    @State var unitSystem = "Imperial";
    
    @State var fName: String = "";
    @State var lName: String = "";
    
    @State var height: String = "";
    @State var weight: String = "";
    @State var selectedSex: Bool = true;
    @State var birthDate: Date = Date();
    @State var useMetric: Bool = false;
    
    
    
    var body: some View {
        
        
        let main = users[0];
        
        
        VStack {
            
            
            
            HStack {
                TextField("First Name", text: $fName)
                    .padding()
                
                
                TextField("Last Name", text: $lName)
                    .padding()
            }
            
            TextField("Height: \(unitMessage)", text: $height).padding()
                .keyboardType(.decimalPad)
            
            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                Text("Birthday: ")
            } .padding()
            
            Picker("Sex", selection: $selectedSex) {
                Text("Male").tag(true)
                Text("Female").tag(false)
            }
            
            Text("Activity Level")
            
            
            Slider(value: $activityLevel, in: 1...1.75, step: 0.15)
                .frame(width: 300)
            
            Text("Activity Level \(activityLevel, specifier: "%.2f")")
            
            
            if (activityLevel == 1) {
                Text("Little to no exercise")
            }
            if (activityLevel == 1.15) {
                Text("Light exercise 1-2 times per week")
            }
            if (activityLevel == 1.30) {
                Text("Moderate exercise 1-2 times per week")
            }
            if (activityLevel == 1.45) {
                Text("Moderate exercise 3-4 times per week")
            }
            if (activityLevel == 1.60) {
                Text("Heavy exercise 3-4 times per week")
            }
            if (activityLevel == 1.75) {
                Text("Heavy exercise almost everyday")
            }
            
            
            Button ("Currently using \(unitSystem)") {
                
                useMetric = !useMetric;
                
                if (useMetric) {
                    unitSystem = "Metric";
                    unitMessage = "cm";
                } else {
                    unitSystem = "Imperial";
                    unitMessage = "in";
                }
            }
            
            
            Button("Update") {
                
                if let newHeight = Double(height) {
                    
                    
                    if (useMetric) {
                        
                        if (newHeight > 90 && newHeight < 260) {
                            
                            main.Height = Double(System.convertMetricHeight(inputHeight: newHeight));
                        } else {
                            alertMsg += "\nPlease enter a height between 90 and 260cm";
                            showAlert = true;
                        }
                    } else {
                        if (newHeight > 36 && newHeight < 108) {
                            
                            main.Height = Double(height)!;
                        } else {
                            alertMsg += "\nPlease enter a height between 36 and 108in";
                            showAlert = true;
                        }
                    }
                    
                    
                    
                } else {
                    alertMsg = "Please enter a valid number";
                    showAlert = true;
                }
                
                
                main.ActivityLevel = activityLevel;
                
                if (fName != "") {
                    main.FirstName = fName;
                }
                
                main.Birthday = birthDate;
                
                
                main.Sex = selectedSex;
                
                main.UseMetric = useMetric;
                
            }
            
            
        }.alert(alertMsg, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                showAlert = false;
                alertMsg = "";
            }
        }
        
        
    }
    
}



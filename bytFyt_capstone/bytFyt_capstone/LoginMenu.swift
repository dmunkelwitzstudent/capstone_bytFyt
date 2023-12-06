//
//  LoginMenu.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/9/23.
//

import SwiftUI
import SwiftData

struct LoginMenu: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User];
    
    @State var activityLevel: Double = 1;
    
    var body: some View {
        

        
        
        @State var fName: String = "";
        @State var lName: String = "";
        
        @State var height: String = "";
        @State var weight: String = "";
        @State var date: Date = Date();
        
        Spacer()
        
        HStack {
            TextField("First Name", text: $fName).padding();
            TextField("Last Name", text: $lName).padding();
        }
        
        HStack {
            TextField("Height", text: $height).padding();
            TextField("Weight", text: $weight).padding();
        }

        var x: Int = 2;
        Picker(selection: .constant(x), label: Text("Sex")) {
            Text("Male").tag(1)
            Text("Female").tag(2)
        }

        Text("Activity Level")
        
        
        Slider(value: $activityLevel, in: 0...1)
            .frame(width: 300)

        Text("Activity Level \(activityLevel, specifier: "%.1f")")

        
        
        
        Button ("Use Metric") {
            
        }

        
        Spacer()

        Button ("Submit") {
            
            var main = User.init(firstName: fName, lastName: lName, birthday: date, sex: true, height: 70, startWeight: 200.0, activity: activityLevel, calorieGoal: 0, sleepGoal: 0, weightGoal: 0, metric: false)
            
            ActiveView()
        }
        
        
    }
}

#Preview {
    LoginMenu()
        .modelContainer(for: User.self, inMemory: true)
}

//
//  LoginMenu.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/9/23.
//

import SwiftUI

struct LoginMenu: View {
    var body: some View {
        

        
        
        @State var fName: String = "";
        @State var lName: String = "";
        
        @State var height: String = "";
        @State var weight: String = "";
        @State var date: Date = Date();
        
        HStack {
            TextField("First Name", text: $fName).padding();
            TextField("Last Name", text: $lName).padding();
        }
        
        HStack {
            TextField("Height", text: $height).padding();
            TextField("Weight", text: $weight).padding();
        }


        Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Sex")) {
            Text("Male").tag(1)
            Text("Female").tag(2)
        }

       Text("All Information is stored locally on your device!")
        Button("Submit") {
            var main = User.init(firstName: fName, lastName: lName, birthday: date, sex: true, height: Double(height)!, startWeight: Double(weight)!, activity: 1.15, calorieGoal: 0, sleepGoal: 0, weightGoal: 0, metric: false)
        }
    }
}

#Preview {
    LoginMenu()
        .modelContainer(for: Item.self, inMemory: true)
}

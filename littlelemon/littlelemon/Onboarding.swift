//
//  Onboarding.swift
//  littlelemon
//
//  Created by Sara Falangone on 28/02/23.
//

import SwiftUI
let firstNameKey: String = ""
let lastNameKey: String = ""
let emailKey: String = ""
let kIsLoggedIn = "kIsLoggedIn"
struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                HStack {
                    VStack{
                        Text("Little Lemon").bold().font(.custom("Optima", size: 26)).foregroundColor(.green).frame(width:290, alignment: .topLeading)
                        Text("Chicago").font(.title3).italic().foregroundColor(.yellow).frame(width: 200, alignment: .leading)
                    }
                    Image("lemon").resizable().frame(width:60, height: 60)
                }
                .padding(.bottom, 150)
                TextField("First Name", text: $firstName).italic().frame(width: 380).padding()
                TextField("Last Name", text: $lastName).italic().frame(width: 380).padding(.bottom)
                TextField("Email", text: $email).italic().frame(width: 380)
                    .padding(.bottom, 70)
                Button(action: {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: firstNameKey)
                        UserDefaults.standard.set(lastName, forKey: lastNameKey)
                        UserDefaults.standard.set(email, forKey: emailKey)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    } else {
                        showAlert = true
                    }
                }, label: {
                    Text("Register").frame(width: 150, height: 30).foregroundColor(.yellow).bold().background(Color.green).cornerRadius(20)
                })
                Spacer()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn){
                    isLoggedIn = true
                }
            }
            .alert(isPresented: $showAlert){
                Alert(title: Text("alert!"),
                      message: Text("FIELDS CANNOT BE EMPTY"))
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

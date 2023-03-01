//
//  UserProfile.swift
//  littlelemon
//
//  Created by Sara Falangone on 28/02/23.
//

import SwiftUI

struct UserProfile: View {
    let firstNameString: String = UserDefaults.standard.string(forKey: firstNameKey) ?? ""
    let lastNameString: String = UserDefaults.standard.string(forKey: lastNameKey) ?? ""
    let emailString: String = UserDefaults.standard.string(forKey: emailKey) ?? ""
    @Environment(\.presentationMode) var presentantion
    var body: some View {
        VStack {
            Text("Personal information").bold().foregroundColor(.green).padding()
            Image("profile-image-placeholder").resizable().frame(width: 100, height: 100)
            Text(firstNameString)
            Text(lastNameString)
            Text(emailString)
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentantion.wrappedValue.dismiss()
            }, label: {
                Text("Logout").frame(width: 150, height: 30).foregroundColor(.yellow).bold().background(Color.green).cornerRadius(20)
            })
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

//
//  MainPage.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        VStack {
            // Top Row
            HStack {
                HStack {
                    Image("profilePhoto") // Replace with your actual profile photo
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 50)
                        .clipShape(Circle())

                    Text("Profile Name") // Replace with the actual profile name
                        .font(.custom("BalooBhai-Regular", size: 18))
                }

                Spacer()

                Button(action: {
                    let phoneNumber = "060953448" // Replace with the actual phone number
                        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                }) {
                    Image(systemName: "phone.circle.fill") // Use a phone icon
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue) // Color for the button
                }
            }
            .padding()

            Spacer()

            // Footer with TabView
            TabView {
               HomeView()
                   .tabItem {
                       Image(systemName: "house.fill")
                       Text("Home")
                   }

               SettingsView()
                   .tabItem {
                       Image(systemName: "gear")
                       Text("Settings")
                   }

               ProfileView()
                   .tabItem {
                       Image(systemName: "person.fill")
                       Text("Profile")
                   }
           }
            .font(.custom("BalooBhai-Regular", size: 12))
        }
    }
}

#Preview {
    MainPage()
}

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
            Spacer()
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
            .font(.custom("BalooBhai-Regular", size: 15))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainPage()
}

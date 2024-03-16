//
//  HomeView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("customPhoneNumber") var customPhoneNumber: String = ""
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image("profilePhoto")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 50)
                        .clipShape(Circle())
                    
                    Text("Profile Name") // Replace with the actual profile name
                        .font(.custom("BalooBhai-Regular", size: 18))
                }
                
                Spacer()
                
                Button(action: {
                    let phoneNumber = customPhoneNumber
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
        }
    }
}

#Preview {
    HomeView()
}

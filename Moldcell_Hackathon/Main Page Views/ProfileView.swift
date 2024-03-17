//
//  ProfileView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI

struct ProfileView: View {
    @State private var bio: String = "This is a sample bio. Tap to edit."
    @State private var profileImage: Image = Image(systemName: "person.crop.circle.fill")
    @State private var isEditingProfile: Bool = false
    @AppStorage("Nume") var name: String = ""
    @AppStorage("customPhoneNumber") var customPhoneNumber: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("profilePhoto")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())

            Text(name)
                .font(.custom("BalooBhai-regular", size: 25))
                .fontWeight(.bold)

            Text(bio)
                .font(.custom("BalooBhai-regular", size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Edit Profile") {
                isEditingProfile = true
            }
            .font(.custom("BalooBhai-regular", size: 20))
            .sheet(isPresented: $isEditingProfile) {
                EditProfileView(username: $name, bio: $bio, profileImage: $profileImage)
            }

            Spacer()
        }
        .padding()
    }
}

struct EditProfileView: View {
    @Binding var username: String
    @Binding var bio: String
    @Binding var profileImage: Image

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    HStack {
                        Image("profilePhoto")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                        Spacer()
                        Image("baba")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                }
                .font(.custom("BalooBhai-regular", size: 20))

                Section(header: Text("Username")) {
                    TextField("Username", text: $username)
                        .font(.custom("BalooBhai-regular", size: 20))
                }
                .font(.custom("BalooBhai-regular", size: 15))

                Section(header: Text("Bio")) {
                    TextEditor(text: $bio)
                        .font(.custom("BalooBhai-regular", size: 20))
                }
                .font(.custom("BalooBhai-regular", size: 15))
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    ProfileView()
}

//
//  SettingsView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI
import Photos
import Contacts

struct SettingsView: View {
    @State private var accessPhotos = false
    @State private var accessContacts = false
    @State private var useDefaultNumber = true
    @State private var customPhoneNumber = ""

    var body: some View {
        Form {
            Toggle("Access Photos", isOn: $accessPhotos)
                .onChange(of: accessPhotos) { newValue in
                    requestPhotoAccess(isGranted: newValue)
                }

            Toggle("Access Contacts", isOn: $accessContacts)
                .onChange(of: accessContacts) { newValue in
                    requestContactAccess(isGranted: newValue)
                }

            Section(header: Text("Emergency Phone Number")) {
                Toggle("Use default number (112)", isOn: $useDefaultNumber)

                if !useDefaultNumber {
                    TextField("Enter custom number", text: $customPhoneNumber)
                        .keyboardType(.numberPad)
                }
            }
        }
        .navigationBarTitle("Settings")
    }

    private func requestPhotoAccess(isGranted: Bool) {
        guard isGranted else { return }
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                print("Photos access granted.")
            default:
                print("Photos access denied.")
            }
        }
    }

    private func requestContactAccess(isGranted: Bool) {
        guard isGranted else { return }
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                print("Contacts access granted.")
            } else {
                print("Contacts access denied.")
            }
        }
    }
}

#Preview {
    SettingsView()
}

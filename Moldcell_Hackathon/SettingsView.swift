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
    @AppStorage("customPhoneNumber") var customPhoneNumber: String = "112"

    var body: some View {
        Form {
            Toggle("Permite acces la Galerie", isOn: $accessPhotos)
                .onChange(of: accessPhotos) { newValue in
                    requestPhotoAccess(isGranted: newValue)
                }

            Toggle("Permite acces la Contacte", isOn: $accessContacts)
                .onChange(of: accessContacts) { newValue in
                    requestContactAccess(isGranted: newValue)
                }

            Section(header: Text("Apel de Urgenta")) {
                Toggle("Foloseste numarul de urgenta (112)", isOn: $useDefaultNumber)
                    .onChange(of: useDefaultNumber) { newValue in
                        if newValue {
                            customPhoneNumber = "112"
                        } else {
                            customPhoneNumber = ""
                        }
                    }

                if !useDefaultNumber {
                    TextField("Introduceti numarul unui cunoscut", text: $customPhoneNumber)
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

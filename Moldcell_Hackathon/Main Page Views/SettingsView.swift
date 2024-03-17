//
//  SettingsView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI
import Photos
import Contacts
import AVFoundation

struct SettingsView: View {
    @State private var accessPhotos = false
    @State private var accessContacts = false
    @State private var accessCamera = false
    @State private var useDefaultNumber = true
    @State private var navigateToLogin = false
    @AppStorage("customPhoneNumber") var customPhoneNumber: String = "112"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Acces si Permisiuni")) {
                    Toggle("Permite acces la Galerie", isOn: $accessPhotos)
                        .onChange(of: accessPhotos) { newValue in
                            requestPhotoAccess(isGranted: newValue)
                        }
                    
                    Toggle("Permite acces la Contacte", isOn: $accessContacts)
                        .onChange(of: accessContacts) { newValue in
                            requestContactAccess(isGranted: newValue)
                        }
                    
                    Toggle("Permite acces la Camera", isOn: $accessCamera)
                        .onChange(of: accessCamera) { newValue in
                            requestCameraAccess(isGranted: newValue)
                        }
                }
                
                Section(header: Text("Apel de Urgenta")) {
                    Toggle("Foloseste numarul de urgenta (112)", isOn: $useDefaultNumber)
                        .onChange(of: useDefaultNumber) { newValue in
                            customPhoneNumber = newValue ? "112" : ""
                        }

                    if !useDefaultNumber {
                        TextField("Introduceti numarul unui cunoscut", text: $customPhoneNumber)
                            .keyboardType(.numberPad)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                                }
                            }
                    }
                }
                
                Section(header: Text("Delogare")) {
                    Button("Delogheaza-te") {
                        navigateToLogin = true
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .scrollContentBackground(.hidden)
            .background(
                NavigationLink(destination: LoginPage().navigationBarBackButtonHidden(true), isActive: $navigateToLogin) {
                    EmptyView()
                }
                    .hidden()
            )
        }
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
    private func requestCameraAccess(isGranted: Bool) {
        self.accessCamera = isGranted // Directly set the state based on the toggle

        guard isGranted else { return }

        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                self.accessCamera = granted // Update the state based on user's decision
                if granted {
                    print("Camera access granted.")
                } else {
                    // If access is denied, consider opening the app settings
                    print("Camera access denied.")
                    if let appSettingsURL = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(appSettingsURL) {
                        UIApplication.shared.open(appSettingsURL)
                    }
                }
            }
        }
    }
}
    

#Preview {
    SettingsView()
}

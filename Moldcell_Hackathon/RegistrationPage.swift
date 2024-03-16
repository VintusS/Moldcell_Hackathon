//
//  RegistrationPage.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 15.03.2024.
//

import SwiftUI

struct RegistrationPage: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var confirmPhoneNumber: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isAgreedToTerms = false
    @State private var showValidationErrors: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()

            Text("SilverLink")
                .font(.custom("BalooBhai-Regular", size: 40))
                .fontWeight(.bold)
            
            Text("Completati formularul de inregistrare")
                .font(.custom("BalooBhai-Regular", size: 15))
                .fontWeight(.regular)

            Group {
                customTextField(placeholder: "Nume", text: $name, isFieldValid: !name.isEmpty)
                customTextField(placeholder: "Numar de Telefon", text: $phoneNumber, isFieldValid: !phoneNumber.isEmpty)
                customTextField(placeholder: "Confirma Numarul de Telefon", text: $confirmPhoneNumber, isFieldValid: phoneNumber == confirmPhoneNumber && !confirmPhoneNumber.isEmpty)
                customSecureField(placeholder: "Parola", text: $password, isFieldValid: !password.isEmpty)
                customSecureField(placeholder: "Confirma Parola", text: $confirmPassword, isFieldValid: password == confirmPassword && !confirmPassword.isEmpty)
            }

            HStack {
                Button(action: {
                    isAgreedToTerms.toggle()
                }) {
                    Image(systemName: isAgreedToTerms ? "checkmark.square.fill" : "square")
                        .foregroundColor(isAgreedToTerms ? .blue : .gray)
                    Text("Sunt de acord cu")
                        .font(.custom("BalooBhai-Regular", size: 15))
                        .foregroundColor(Color.black.opacity(0.5))
                }

                NavigationLink(destination: TermsandConditions()) {
                    Text("Termenii si Conditiile")
                        .font(.custom("BalooBhai-Regular", size: 15))
                        .foregroundColor(Color.blue)
                        .underline()
                }
            }
            .frame(width: 300, height: 60)

            Button("INREGISTREAZA-TE ACUM") {
                showValidationErrors = name.isEmpty || phoneNumber.isEmpty || confirmPhoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty
                if !showValidationErrors {
                    // Proceed with login
                }
            }
            .font(.custom("BalooBhai-Regular", size: 20))
            .frame(width: 300, height: 60)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(90)
            .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(hex: "F7F7F7"))
    }

    private func customTextField(placeholder: String, text: Binding<String>, isFieldValid: Bool) -> some View {
        TextField(placeholder, text: text)
            .font(.custom("BalooBhai-Regular", size: 15))
            .foregroundColor(Color.black.opacity(0.5))
            .frame(width: 300, height: 60)
            .padding(.leading, 20)
            .background(phoneNumber.isEmpty && showValidationErrors ? Color.red.opacity(0.1) : Color.white)
            .cornerRadius(90)
            .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)
    }

    private func customSecureField(placeholder: String, text: Binding<String>, isFieldValid: Bool) -> some View {
        SecureField(placeholder, text: text)
            .font(.custom("BalooBhai-Regular", size: 15))
            .foregroundColor(Color.black.opacity(0.5))
            .frame(width: 300, height: 60)
            .padding(.leading, 20)
            .background(phoneNumber.isEmpty && showValidationErrors ? Color.red.opacity(0.1) : Color.white)
            .cornerRadius(90)
            .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)
    }
}

#Preview {
    RegistrationPage()
}

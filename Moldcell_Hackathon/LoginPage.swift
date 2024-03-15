//
//  LoginPage.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 15.03.2024.
//

import SwiftUI

struct LoginPage: View {
    @State private var phoneNumber: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Image("icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(90)

            Text("SilverLink")
                .font(.custom("BalooBhai-Regular", size: 40))                .fontWeight(.bold)

            ZStack {
                RoundedRectangle(cornerRadius: 90)
                    .frame(width: 300, height: 60)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)

                TextField("Numar de Telefon", text: $phoneNumber)
                    .font(.custom("BalooBhai-Regular", size: 15))
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(width: 280, height: 60)
                    .padding(.leading, 20)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 90)
                    .frame(width: 300, height: 60)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)

                SecureField("Parola", text: $password)
                    .font(.custom("BalooBhai-Regular", size: 15))
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(width: 280, height: 60)
                    .padding(.leading, 20)
            }
            .padding()
            Button("CONECTEAZA-TE") {
                // Handle the sign-in action
            }
                .font(.custom("BalooBhai-Regular", size: 20))
                .frame(width: 300, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(90)
                .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)

            Text("Inca nu ai un cont?")
                .font(.custom("BalooBhai-Regular", size: 15))
                .foregroundColor(Color.black.opacity(0.5))
            
            Button("INREGISTREAZA-TE ACUM") {
                // Handle the sign-up action
            }
            .font(.custom("BalooBhai-Regular", size: 20))
            
            Spacer()
            // "Terms and conditions" link
            Button("Termeni si Conditii") {
                // Handle the link action
            }
            .font(.custom("BalooBhai-Regular", size: 15))
            .foregroundStyle(Color.black.opacity(0.5))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(hex: "F7F7F7"))
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

struct FilledRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    LoginPage()
}

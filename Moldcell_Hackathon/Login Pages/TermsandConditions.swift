//
//  TermsandConditions.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI

struct TermsandConditions: View {
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Terms and Conditions")
                        .font(.custom("BalooBhai-Regular", size: 24))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    Text("Welcome to SilverLink!")
                        .font(.custom("BalooBhai-Regular", size: 18))
                        .padding(.bottom, 5)

                    Text("1. Acceptance of Terms")
                        .font(.custom("BalooBhai-Regular", size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text("By accessing and using SilverLink, you accept and agree to be bound by the terms and provision of this agreement. In addition, when using these particular services, you shall be subject to any posted guidelines or rules applicable to such services.")
                        .font(.custom("BalooBhai-Regular", size: 16))
                        .padding(.bottom, 5)

                    Text("2. Modification of Terms")
                        .font(.custom("BalooBhai-Regular", size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    Text("We reserve the right to change the terms and conditions at any time without notice. Your continued use of SilverLink after such changes constitutes your acceptance of the new Terms and Conditions.")
                        .font(.custom("BalooBhai-Regular", size: 16))
                        .padding(.bottom, 5)

                    // Add more sections as needed

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Terms and Conditions", displayMode: .inline)
        }
}

#Preview {
    TermsandConditions()
}

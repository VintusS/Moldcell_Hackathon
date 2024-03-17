//
//  GalleryView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import SwiftUI

struct GalleryView: View {
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var imageCaption: String = ""
    @State private var showToast = false

    let customFont: String = "BalooBhai-Regular"

    var body: some View {
        VStack {
            Spacer()

            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()

                TextField("Spune ce gandesti...", text: $imageCaption)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .font(.custom(customFont, size: 18))
                    .padding()
            } else {
                Text("No image selected")
                    .font(.custom(customFont, size: 18))
                    .foregroundColor(.gray)
            }

            Spacer()

            Button("FA O POZA") {
                isShowingImagePicker = true
            }
            .font(.custom(customFont, size: 20))
            .frame(width: 300, height: 60)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)
            .padding()

            if selectedImage != nil {
                Button("TRIMITE IMAGINEA") {
                    withAnimation {
                        showToast = true
                        selectedImage = nil // Simulate sending the image and then deleting it
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }
                .font(.custom(customFont, size: 20))
                .frame(width: 300, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 3)
                .padding()
            }
        }
        .overlay(
            ToastView(show: $showToast)
                .animation(.easeInOut, value: showToast)
                .opacity(showToast ? 1 : 0),
            alignment: .top
        )
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
        }
    }
}

struct ToastView: View {
    @Binding var show: Bool
    let customFont: String = "BalooBhai-Regular"

    var body: some View {
        if show {
            Text("IMAGINEA TRIMISA CU SUCCES")
                .font(.custom(customFont, size: 18))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(25)
                .transition(.slide)
                .animation(.easeInOut, value: show)
        }
    }
}


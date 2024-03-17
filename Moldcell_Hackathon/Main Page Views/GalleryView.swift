//
//  GalleryView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var multipeerSession = MultipeerSession()
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var imageCaption: String = ""

    var body: some View {
        VStack {
            // Top bar for hosting and joining session
            HStack {
                Button("Host Session") {
                    multipeerSession.startHosting()
                }
                .frame(maxWidth: .infinity)

                Button("Join Session") {
                    multipeerSession.joinSession()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()

            Spacer()

            // Image and caption display
            if let image = multipeerSession.receivedImage {
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()

//                    Text(multipeerSession.receivedCaption)
//                        .font(.caption)
//                        .padding()
                }
            }

            Spacer()

            // Image picker, caption entry, and send button
            VStack {
                Button("Choose Image") {
                    isShowingImagePicker = true
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                }

                TextField("Enter caption...", text: $imageCaption)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if let selectedImage = selectedImage {
                    Button("Send Image") {
                        if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                            // Combine the image data and caption into one data object
                            let combinedData = ImageData(image: imageData, caption: imageCaption)
                            if let encodedData = try? JSONEncoder().encode(combinedData) {
                                try? multipeerSession.mcSession.send(encodedData, toPeers: multipeerSession.mcSession.connectedPeers, with: .reliable)
                            }
                        }
                    }
                }
            }
            .padding()

            Spacer()
        }
    }
}

struct ImageData: Codable {
    let image: Data
    let caption: String
}

#Preview {
    GalleryView()
}

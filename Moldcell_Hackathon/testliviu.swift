//
//  testliviu.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        player.play() // Start playing the video
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

struct ContentViewu: View {
    var body: some View {
        VideoPlayerView(videoURL: URL(string: "https://play.md/embed/4007649?title=false&autoplay=false")!)
            .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    ContentViewu()
}

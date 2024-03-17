//
//  MultiPeerConnectivity.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import MultipeerConnectivity

class MultipeerSession: NSObject, ObservableObject, MCSessionDelegate, MCBrowserViewControllerDelegate {
    var peerID: MCPeerID
    var mcSession: MCSession
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    @Published var receivedImage: UIImage?

    override init() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        mcSession.delegate = self
    }

    func startHosting() {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "image-share", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }

    func joinSession() {
        let browser = MCBrowserViewController(serviceType: "image-share", session: mcSession)
        browser.delegate = self
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(browser, animated: true)
        }
    }

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        // Handle session state changes
        print("Peer \(peerID.displayName) changed state to \(state.rawValue)")
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // Handle receiving data
        DispatchQueue.main.async {
            if let image = UIImage(data: data) {
                self.receivedImage = image
            }
        }
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Handle receiving a stream
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Handle the start of receiving a resource
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Handle finishing receiving a resource
    }

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
}


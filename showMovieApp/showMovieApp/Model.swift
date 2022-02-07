//
//  Model.swift
//  showMovieApp
//
//  Created by Nikolay T on 31.01.2022.
//

import Foundation
import UIKit
import AVKit

struct MovieData {
    var filmName: String
    var filmUrlString: String
    var filmImage: UIImage
    var imageIsLoaded: Bool = false
}


class VideoPresenter {
    private var player: AVPlayer
    private var playerController: AVPlayerViewController
    
    init(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            self.player = AVPlayer()
            self.playerController = AVPlayerViewController()
            return
            
        }
        
        self.player = AVPlayer(url: url)
        self.playerController = AVPlayerViewController()
    }
    
    init() {
        self.player = AVPlayer()
        self.playerController = AVPlayerViewController()
    }
    
    public func videoSnapshot(urlString: String) -> UIImage? {
        
        guard let vidURL = URL(string: urlString) else {
            return nil
        }
        
        let asset = AVURLAsset(url: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 5, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }
    
    public func loadPlayer(urlString: String) {
        guard let url: URL = URL(string: urlString) else { return }
            
        self.player = AVPlayer(url: url)
        
        self.playerController.player = player
        self.playerController.player?.play()
    }
    
    public func getPlayerController() -> AVPlayerViewController {
        return self.playerController
    }
}

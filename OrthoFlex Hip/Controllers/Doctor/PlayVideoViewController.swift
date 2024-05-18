//
//  PlayVideoViewController.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 23/02/24.
//

import UIKit
import AVFoundation
import AVKit

class PlayVideoViewController: UIViewController {
    
    @IBOutlet weak var videoTitle: UILabel!
    
    @IBOutlet weak var videoView: UIView!
    
    var player:AVPlayer?
    
    var videoUrl = String()
    
    
    var titles = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        videoTitle.text = titles
        LoadingIndicator.shared.showLoading(on: self.view)
        self.playVideo(with: videoUrl)
    }
    
    
    func playVideo(with url: String) {
        
            let base = ServiceAPI.baseURL
           guard let videoURL = URL(string: base+url) else {
               print("Invalid video URL")
               LoadingIndicator.shared.hideLoading()
               return
           }

           player = AVPlayer(url: videoURL)
           
           guard let player = player else {
               //  print("Failed to initialize AVPlayer")
               return
           }
           
           let playerViewController = AVPlayerViewController()
           playerViewController.player = player
           playerViewController.entersFullScreenWhenPlaybackBegins = false
           playerViewController.allowsPictureInPicturePlayback = false
            LoadingIndicator.shared.hideLoading()
           addChild(playerViewController)
           videoView.addSubview(playerViewController.view)
           playerViewController.view.frame = videoView.bounds
           playerViewController.didMove(toParent: self)
           
           // Add observer for player status
           player.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: .new, context: nil)
       }

       // Implement key-value observation method
       override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == #keyPath(AVPlayer.status) {
               if let player = player {
                   if player.status == .failed {
                       if let error = player.error {
                          print("Failed to load video: \(error)")
                       } else {
                           //print("Failed to load video with an unknown error.")
                       }
                   }else {
                       player.play()
                   }
               } else {
                  // print("AVPlayer is nil.")
               }
           }
       }
    
    
    
    
    @IBAction func backTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    


}

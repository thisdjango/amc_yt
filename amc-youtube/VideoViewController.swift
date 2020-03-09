//
//  VideoViewController.swift
//  amc-youtube
//
//  Created by thisdjango on 02.03.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoViewController: UIViewController {
    
    var titleVideo = String()
    var idVideo = String()
    var descVideo = String()

    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var titleOfVideo: UILabel!
    @IBOutlet weak var descriptionVideo: UITextView!
    

    @IBAction func stop(_ sender: Any) {
        playerView.stopVideo()
    }
    
    @IBAction func play(_ sender: Any) {
        playerView.playVideo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleOfVideo.text = titleVideo
        descriptionVideo.text = descVideo
        playerView.load(withVideoId: idVideo)
        print("Params of Video", titleVideo, idVideo)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

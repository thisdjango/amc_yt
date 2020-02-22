//
//  Service.swift
//  amc-youtube
//
//  Created by thisdjango on 14.02.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit


struct TitleVideoSet{
    var titlesVideoset:[String] = []
}

struct PreviewImagesVideoSet{
    var previewImagesVideos:[UIImage] = []
}


class Service {
    
    static let shared = Service()

    let TOKEN = "AIzaSyDvlb82XRQVe0Kyl_olqWyJ1SwddGl_ImQ"
    let CHANNEL_ID = "UCLtPOhNcK2_oSeJl43y-qWw"
    var done: Bool = false
    var playlistsData: [Item] = []
    var tmp_titles: [String] = []
    var tmp_imgs: [UIImage] = []
    var labels: [String] = []
    var previewImages: [PreviewImagesVideoSet] = []
    var titlesVideo: [TitleVideoSet] = []
    var videos: [Videos] = []
    
    static func grabData(_ completionHandler: @escaping (()->()) ){
        
        let PLAYLIST_URL_LINK = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=UCLtPOhNcK2_oSeJl43y-qWw&maxResults=50&key=AIzaSyDvlb82XRQVe0Kyl_olqWyJ1SwddGl_ImQ"
        
        guard let url = URL(string: PLAYLIST_URL_LINK) else {
            print("unlucky :(")
            return
        }
        let request = URLRequest(url: url)
        print("in loadContent")
        let task0 = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "no description for error provided!\n")
                return
            }

            guard let data = data else { return }
            
            guard let playlist = try? JSONDecoder().decode(Playlist.self, from: data) else {
                print("Error: can't parse gists")
                return
            }
            shared.playlistsData = playlist.items
            completionHandler()
        }
        task0.resume()
    }
    
    static func grabTitleAndVideos(){
        
        shared.playlistsData.forEach { playlist in
            // Title
            shared.labels.append(playlist.snippet.title)
            
            //Videos
            let VIDEOS_URL_LINK = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=\(playlist.id)&key=AIzaSyDvlb82XRQVe0Kyl_olqWyJ1SwddGl_ImQ"
            
            guard let url = URL(string: VIDEOS_URL_LINK) else {
                print("getVideos unlucky")
                return
            }
            
            let request = URLRequest(url: url)
            let task1 = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard error == nil else {
                    print(error?.localizedDescription ?? "no description for error provided!\n")
                    return
                }
                
                guard let data = data else { return }
                
                guard let videos1 = try? JSONDecoder().decode(Videos.self, from: data) else {
                    print("Error: can't parse gists")
                    return
                }
                shared.videos.append(videos1)
                print(shared.videos.count, "Task for \"\(playlist.snippet.title)\" is ready.in grabTitleAndVideos")
                if Service.shared.videos.count == Service.shared.playlistsData.count {
                    Service.grabMediaContent()
                }
            }
            task1.resume()
        }
    }
    
    static func grabMediaContent(){
        shared.videos.forEach { video_set in
            video_set.items.forEach { one in
                let urlString = one.snippet.thumbnails.high.url
                guard let url = URL(string: urlString) else { return }
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "no description for error provided!\n")
                        return
                    }
                    guard let data = data else { return }
                    if let image = UIImage(data: data) {
                        shared.tmp_imgs.append(image)
                        shared.tmp_titles.append(one.snippet.title)
                        // ----
                    }
                    print("Task for \"\(one.snippet.title)\" is ready.in grabMedia")
                    print(video_set.items[video_set.items.count - 1].snippet.title)
                    if one.snippet.title == video_set.items[video_set.items.count - 1].snippet.title {
                        shared.previewImages.append(PreviewImagesVideoSet(previewImagesVideos: shared.tmp_imgs))
                        shared.titlesVideo.append(TitleVideoSet(titlesVideoset: shared.tmp_titles))
                        shared.tmp_titles = [] as [String]
                        shared.tmp_imgs = [] as [UIImage]
                    }
//                    if Service.shared.previewImages.count == Service.shared.titlesVideo.count{
//                        DispatchQueue.main.async {
//                            tableView.reloadData()
//                        }
//                    }
                }
                task.resume()
            }

        }
    }
}

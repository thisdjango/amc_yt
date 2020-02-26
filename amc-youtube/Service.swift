//
//  Service.swift
//  amc-youtube
//
//  Created by thisdjango on 14.02.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit

class Service {
    
    static let shared = Service()

    private let TOKEN = "AIzaSyDvlb82XRQVe0Kyl_olqWyJ1SwddGl_ImQ"
    private let CHANNELID = "UCLtPOhNcK2_oSeJl43y-qWw"
    
    var playlistsData: [Item] = []
    var labels: [String] = []
    var videos: [Videos] = []
    var localImages: [UIImage] = []
    var localTitles: [String] = []
    var videosTitles: [[String]] = []
    var videosImages: [[UIImage]] = []
    
    private init() {}
    
    func grabPlaylistsData(completionHandler: @escaping (_ playlists: [Item]?) -> ()) {
        
        let PLAYLIST_URL_LINK = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=\(CHANNELID)&maxResults=50&key=\(TOKEN)"
        
        guard let url = URL(string: PLAYLIST_URL_LINK) else {
            print("unlucky :(")
            completionHandler(nil)
            return
        }
        
        let request = URLRequest(url: url)
        print("in loadContent")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "no description for error provided!\n")
                return
            }

            guard let data = data else { return }
            
            guard let playlist = try? JSONDecoder().decode(Playlist.self, from: data) else {
                print("Error: can't parse gists")
                return
            }
            // saving playlists to array
            self.playlistsData = playlist.items
            completionHandler(playlist.items)
        }
        
        task.resume()
    }
    
    func grabTitleAndVideos(for playlist: Item, completionHandler: @escaping (_ videos: Videos?) -> ()) {
            
        //Videos
        let VIDEOS_URL_LINK = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=\(playlist.id)&key=AIzaSyDvlb82XRQVe0Kyl_olqWyJ1SwddGl_ImQ"
        
        guard let url = URL(string: VIDEOS_URL_LINK) else {
            print("getVideos unlucky")
            completionHandler(nil)
            return
        }
            
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            guard error == nil else {
                print(error?.localizedDescription ?? "no description for error provided!\n")
                completionHandler(nil)
                return
            }
                
            guard let data = data else {
                completionHandler(nil)
                return
            }
                
            guard let videos = try? JSONDecoder().decode(Videos.self, from: data) else {
                print("Error: can't parse videos.")
                completionHandler(nil)
                return
            }
            
            self.videos.append(videos)
            
            // Grab Title
            self.labels.append(playlist.snippet.title)
            
            // Расскоментируй ниже, что бы посмотреть как работает загрузка данных
            //print(self.videos.count, "Task for \"\(playlist.snippet.title)\" is ready. Videos \(videos.items.count)")
            completionHandler(videos)
        }
        
        task.resume()
    }
    
    func grabMediaContent(for videos: Videos, completionHandler: @escaping (_ success: Bool) -> ()) {
        
        for video in videos.items {
            let urlString = video.snippet.thumbnails.high.url
            
            guard let url = URL(string: urlString) else {
                continue
            }
            
            DispatchQueue.global(qos: .userInteractive).sync {
                guard let data = try? Data(contentsOf: url) else {
                    // TODO: кейс, когда картинка не досталась -> делать по дефолту
                    return
                }

                if let image = UIImage(data: data) {
                    self.localImages.append(image)
                    self.localTitles.append(video.snippet.title)
                    // Расскоментируй ниже, что бы посмотреть как работает загрузка данных
                    //print("Task for \"\(video.snippet.title)\" is ready.")
                }
            }
        }
        
        videosImages.append(localImages)
        videosTitles.append(localTitles)
        localImages.removeAll()
        localTitles.removeAll()
        completionHandler(true)
    }
}

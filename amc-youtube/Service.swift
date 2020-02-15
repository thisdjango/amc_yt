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

    let TOKEN = "AIzaSyDvlb82XRQVe0Kyl_olqWyJ1SwddGl_ImQ"
    let CHANNEL_ID = "UCLtPOhNcK2_oSeJl43y-qWw"

    var labels:[String] = []
    var previewImages:[PreviewImagesVideoSet] = []
    var titlesVideo:[TitleVideoSet] = []
    var videos:[Videos] = []
    
    static func grabData(tableView: UITableView){
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
            playlistsData = playlist.items
            print(playlistsData)
            grabTitleAndVideos(tableView: tableView)
        }
        
        task0.resume()
    }
    
    static func grabTitleAndVideos(tableView: UITableView){
        print("Titles: ")
        for playlist in playlistsData {
            shared.labels.append(playlist.snippet.title)
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
                print("without er")
                shared.videos.append(videos1)
                grabMediaContent(tableView: tableView)
            }
            
            task1.resume()
        }
    }
    
    static func grabMediaContent(tableView: UITableView){
        var str_mov:[String] = []
        var img_mov:[UIImage] = []
        var urlString:String;
        for video_set in shared.videos {
            for one in video_set.items {
                str_mov.append(one.snippet.title)
                print(one.snippet.title)
                urlString = one.snippet.thumbnails.high.url;
                guard let url = URL(string: urlString) else { return }
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "no description for error provided!\n")
                        return
                    }
                    guard let data = data else { return }
                    if let image = UIImage(data: data) {
                        img_mov.append(image)
                    }
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }
                task.resume()
            }
            shared.previewImages.append(PreviewImagesVideoSet(previewImagesVideos: img_mov))
            shared.titlesVideo.append(TitleVideoSet(titlesVideoset: str_mov))
            str_mov = [] as [String]
            img_mov = [] as [UIImage]
        }
    }
}

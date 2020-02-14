//
//  Service.swift
//  amc-youtube
//
//  Created by thisdjango on 14.02.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit


class Service {

    static func grabData(completion: @escaping () -> (String)){
        let url_str = completion()
        guard let url = URL(string: url_str) else {
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
        }
        
        task0.resume()
    }
    
    static func grabTitleAndVideo(completion: @escaping (Item) -> ()){
        print("Titles: ")
        for playlist in playlistsData {
            print(playlist.snippet.title)
            completion(playlist)
            
            let VIDEOS_URL_LINK = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=\(playlist.id)&key=\(TOKEN)"
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
                
                videos.append(videos1)
            }
            
            task1.resume()
        }
    }
    
    static func grabMediaContent(completion: @escaping ([UIImage], [String]) -> ()){
        var str_mov:[String] = []
        var img_mov:[UIImage] = []
        for video_set in videos {
            for one in video_set.items {
                str_mov.append(one.snippet.title)
                let urlString = one.snippet.thumbnails.high.url;
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
            }
                task.resume()
            }
            completion(img_mov, str_mov)
            str_mov = [] as [String]
            img_mov = [] as [UIImage]
        }
    }
}

//
//  TableViewCell.swift
//  amc-youtube
//
//  Created by thisdjango on 29.01.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit

let TOKEN = "AIzaSyDvlb82XRQVe0Kyl_olqWyJ1SwddGl_ImQ"
let CHANNEL_ID = "UCLtPOhNcK2_oSeJl43y-qWw"
let PLAYLIST_URL_LINK = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=\(CHANNEL_ID)&maxResults=50&key=\(TOKEN)"


struct TitleVideoSet{
    var titlesVideoset:[String] = []
}

struct PreviewImagesVideoSet{
    var previewImagesVideos:[UIImage] = []
}
var previewImages:[PreviewImagesVideoSet] = []
var titlesVideo:[TitleVideoSet] = []
var videos:[Videos] = []

class TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mytitle: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionViewDataSourceDelegate(self, forRow: 0)
        print("IN CELL PLAYLIST DATA ----> \(playlistsData.count)")
//        collectionView.showLoader()
        for playlist in playlistsData {
            self.loadImagesTitlesForVideoSet(playlist: playlist)
        }
//        collectionView.hideLoader()
        print(previewImages)
        print(titlesVideo)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let superIndexPath = getIndexPath()
        print(previewImages)
        print("COLLECTIONNN --------> \(previewImages[superIndexPath!.row].previewImagesVideos.count)")
        return previewImages[superIndexPath!.row].previewImagesVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("User tapped on item \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        let superIndexPath = getIndexPath()
        myCell.myimage.image = previewImages[superIndexPath!.row].previewImagesVideos[indexPath.row]
        myCell.mylabel.text = titlesVideo[superIndexPath!.row].titlesVideoset[indexPath.row]
        return myCell
    }
    
    private func loadImagesTitlesForVideoSet(playlist: Item){

    }
            
    
    private func getVideos(playlist: Item) {
        


        
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }


}

extension TableViewCell{
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate: D, forRow row: Int)
    {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.reloadData()
    }
}



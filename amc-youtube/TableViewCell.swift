//
//  TableViewCell.swift
//  amc-youtube
//
//  Created by thisdjango on 29.01.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit

struct TitleVideoSet{
    var titlesVideoset:[String] = []
}

struct PreviewImagesVideoSet{
    var previewImagesVideos:[UIImage] = []
}


class TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mytitle: UILabel!

    var currentIndexPath: IndexPath = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionViewDataSourceDelegate(self, forRow: 0)
        print("IN CELL PLAYLIST DATA ----> \(playlistsData.count)")
        print(Service.shared.previewImages)
        print(Service.shared.titlesVideo)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("IIIIIIIIIIIIIIIIIIIIII\(Service.shared.previewImages[currentIndexPath.row])")
        print("COLLECTIONNN --------> \(Service.shared.previewImages[currentIndexPath.row].previewImagesVideos.count)")
        return Service.shared.previewImages[currentIndexPath.row].previewImagesVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("User tapped on item \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        myCell.myimage.image = Service.shared.previewImages[currentIndexPath.row].previewImagesVideos[indexPath.row]
        myCell.mylabel.text = Service.shared.titlesVideo[currentIndexPath.row].titlesVideoset[indexPath.row]
        return myCell
    }

//    func getIndexPath() -> IndexPath? {
//
//        guard let superView = self.superview.viewWithTag(16) as? UITableView else {
//            print("superview is not a UITableView - getIndexPath")
//            return nil
//        }
//        let indexPath = superView.indexPath(for: self)!
//        return indexPath
//    }
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

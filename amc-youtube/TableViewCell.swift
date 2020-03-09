//
//  TableViewCell.swift
//  amc-youtube
//
//  Created by thisdjango on 29.01.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit

protocol TableViewDelegate{
    func didSendInfo(_ titleV: String, for video_id: String)
}

class TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var tableViewlDelegate: TableViewDelegate?
    var currentIndexPath: IndexPath = IndexPath()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mytitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionViewDataSourceDelegate(self)
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Service.shared.videosImages[currentIndexPath.row].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        myCell.myimage.image = Service.shared.videosImages[currentIndexPath.row][indexPath.row]
        myCell.mylabel.text = Service.shared.videosTitles[currentIndexPath.row][indexPath.row]
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let titlev = Service.shared.videosTitles[currentIndexPath.row][indexPath.row]
        let id = Service.shared.videosId[currentIndexPath.row][indexPath.row]
        tableViewlDelegate?.didSendInfo(titlev, for: id)
    }
}

extension TableViewCell {
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate: D)
    {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.reloadData()
    }
}

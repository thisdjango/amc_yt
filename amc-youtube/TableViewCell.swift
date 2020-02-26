//
//  TableViewCell.swift
//  amc-youtube
//
//  Created by thisdjango on 29.01.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mytitle: UILabel!

    var currentIndexPath: IndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionViewDataSourceDelegate(self)
        
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of items in section: \(Service.shared.videosImages[currentIndexPath.row].count)")
        return Service.shared.videosImages[currentIndexPath.row].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        myCell.myimage.image = Service.shared.videosImages[currentIndexPath.row][indexPath.row]
        myCell.mylabel.text = Service.shared.videosTitles[currentIndexPath.row][indexPath.row]
        print("Создалась Collection view cell \(indexPath.row) with name \(Service.shared.videosTitles[currentIndexPath.row][indexPath.row])")
    
        return myCell
    }
}

extension TableViewCell{
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate: D)
    {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.reloadData()
    }
}

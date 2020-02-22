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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Collection View Cell (numberOfItemsInSection) = \(Service.shared.previewImages[currentIndexPath.row].previewImagesVideos.count)")
        return Service.shared.previewImages[currentIndexPath.row].previewImagesVideos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        print(currentIndexPath.row, indexPath.row)
        myCell.myimage.image = Service.shared.previewImages[currentIndexPath.row].previewImagesVideos[indexPath.row]
        myCell.mylabel.text = Service.shared.titlesVideo[currentIndexPath.row].titlesVideoset[indexPath.row]
        print("Collection View Cell (cellForItemAt) = \(String(describing: myCell.mylabel.text))")
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

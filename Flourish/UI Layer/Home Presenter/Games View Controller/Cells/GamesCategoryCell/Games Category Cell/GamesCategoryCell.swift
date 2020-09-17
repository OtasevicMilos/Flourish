//
//  GamesCategoryCell.swift
//  Flourish
//
//  Created by Janko on 08/09/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class GamesCategoryCell: UITableViewCell {

    @IBOutlet var mainCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainCollectionView.register(UINib(nibName:"GamesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "gamesCollectionCell")
          mainCollectionView.dataSource=self
          mainCollectionView.delegate=self
          mainCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension GamesCategoryCell:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gamesCollectionCell", for: indexPath) as! GamesCollectionCell
        return cell
    }
    
    
}
extension GamesCategoryCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 25, bottom: 0, right: 0)
    }
   
}

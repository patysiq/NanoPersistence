//
//  HomeTableViewCell.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 14/10/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var number = Int.random(in: 1...6)
    var titleText: String = "Oi"
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Unable create cell")
        }
        cell.imageBack.image = UIImage(named: "\(number)")
        cell.titleCollectionCell.text = titleText
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.0, height: 180.0)
    }

}

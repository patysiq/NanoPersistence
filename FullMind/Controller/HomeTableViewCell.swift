//
//  HomeTableViewCell.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 14/10/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTableCell: UILabel!
    var number = Int.random(in: 1...6)
    var textCollection: [String] = ["Oi", "Hello", "Hi"]
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Add Notes
    @IBAction func addCollecttionCell(_ sender: Any) {

        self.collectionView.reloadData()
        }
    }

//MARK: - CollectionView Delegate and Datasourse

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textCollection.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Unable create cell")
        }
        cell.imageBack.image = UIImage(named: "\(number)")
        cell.titleCollectionCell.text = textCollection[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.0, height: 180.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection: \(indexPath.row)")
        print(textCollection[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

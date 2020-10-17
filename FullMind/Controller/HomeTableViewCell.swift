//
//  HomeTableViewCell.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 14/10/20.
//

protocol CustomTableViewCellDelegate {
    func addCollectionCell()
}

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTableCell: UILabel!
    var delegate: CustomTableViewCellDelegate?
    let defalts = UserDefaults.standard
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Add Notes
    @IBAction func addCollecttionCell(_ sender: Any) {
        delegate?.addCollectionCell()
       // defalts.set(true, forKey: "addCellCollection")
    }
}

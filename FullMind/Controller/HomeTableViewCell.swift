//
//  HomeTableViewCell.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 14/10/20.
//

protocol CustomTableViewCellDelegate {
    func addCollectionCell()
    func deleteCategory(_ tag: Int)
}

import UIKit
import CoreData

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTableCell: UILabel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // swiftlint:disable:this force_cast

    var delegate: CustomTableViewCellDelegate?
    var noteText = [Note]()
    var category: Category? {
        didSet {
            loadNotes()
        }
    }
    var indexSelect: Int = 0
    var number = Int.random(in: 1...6)

    override func awakeFromNib() {
        super.awakeFromNib()
       // category?.parentNote
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //loadNotes()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
     // MARK: - Add Notes
    @IBAction func deleteCollecttionCell(_ sender: Any) {
        delegate?.deleteCategory(self.tag)
    }
    // MARK: - Model Manupulation Methods
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        collectionView.reloadData()
    }
//      func loadNotes() {
//        let request : NSFetchRequest<Note> = Note.fetchRequest()
//        do {
//            noteText = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }
//       collectionView.reloadData()
//    }
    func loadNotes() {
        guard let title = category?.title else {return}
        let predicate = NSPredicate(format: "parentCategory.title == %@", title)//(format: "parentCategory.title == %@", arguments: title)
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = predicate
        do {
            noteText = try context.fetch(request)
            collectionView.reloadData()
        } catch {
            print("Error loading categories \(error)")
        }
    }
    
    func updateCellWith(row: [Note]) {
        noteText = row
        collectionView.reloadData()
        }
}
// MARK: - Collection View Delegate and Datasource

extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (noteText.count + 1)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Unable create cell")
        }
        cell.layer.cornerRadius = 20
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        if indexPath.row == 0 {
            cell.imageBack.image = UIImage(named: "addButton")
            cell.titleCollectionCell.text = ""
        }
        if indexPath.row >= 1 {
            cell.imageBack.image = UIImage(named: noteText[indexPath.row - 1].image ?? "\(number)")
            cell.titleCollectionCell.text = noteText[indexPath.row - 1].text
        }
        //add gesture for delete cellCollection
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.0, height: 180.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            CacheManager.setCache("","\(number)", true, indexPath.row, noteText)
        } else if indexPath.row >= 1 {
            CacheManager.setCache(noteText[indexPath.row - 1].text ?? "", noteText[indexPath.row - 1].image ?? "\(number)", false, indexPath.row, noteText)
        }
        delegate?.addCollectionCell()
        indexSelect = indexPath.row
    }
}

//
//  HomeTableViewCell.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 14/10/20.
//

protocol CustomTableViewCellDelegate {
    func addCollectionCell()
}

//protocol getDataNote {
//    func getData() -> [Note]
//}

import UIKit
import CoreData

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTableCell: UILabel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // swiftlint:disable:this force_cast

    var delegate: CustomTableViewCellDelegate?
    var noteText = [Note]()
    var indexSelect: Int = 0
    var number = Int.random(in: 1...6)
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        loadNotes()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

     // MARK: - Add Notes
    @IBAction func addCollecttionCell(_ sender: Any) {
        print("Add alert for delete category")
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
    func loadNotes() {
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        do {
            noteText = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        collectionView.reloadData()
    }

//    func saveData() {
//        if isNewCell {
//            let newNote = Note(context: context)
//            newNote.text = CacheManagerDone.getCache()
//            noteText.append(newNote)
//            print("estou aqui")
//            print(noteText[0].text ?? "falhou")
//        } else {
//            noteText[indexSelect].text = CacheManagerDone.getCache()
//        }
//        saveItems()
//        collectionView.reloadData()
//    }
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
        //loadNotes()
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
            CacheManager.setCache("","\(number)", true, noteText, indexPath.row)
        } else if indexPath.row >= 1 {
            CacheManager.setCache(noteText[indexPath.row - 1].text ?? "", noteText[indexPath.row - 1].image ?? "\(number)", false, noteText, indexPath.row)
        }
        delegate?.addCollectionCell()
        indexSelect = indexPath.row
    }
}

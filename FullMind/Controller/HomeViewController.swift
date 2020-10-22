//
//  ViewController.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 13/10/20.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, CustomTableViewCellDelegate {
   
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var note: UITextView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // swiftlint:disable:this force_cast

    var category = [Category]()
    var notes = [Note]()
    var indexSelected: Int = 0
    var indexPathSelected: IndexPath?
    var number = Int.random(in: 1...6)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set blur view
        blurView.bounds = self.view.bounds
        //Set popupView
        popupView.bounds = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        loadCategories()
        tableView.reloadData()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
   }

// MARK: - Add TablewViewCells - Category

    @IBAction func addTableCellPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.title = textField.text ?? ""
            self.category.append(newCategory)
            self.saveItems()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Note Text Cache for View
    @IBAction func doneButton(_ sender: Any) {
        animateOut(desiredView: popupView)
        animateOut(desiredView: blurView)
        notes.removeAll()
        notes = CacheManager.getNotes()
        guard let isNewNote = CacheManager.getNew() else {return}
        if isNewNote {
            let newNote = Note(context: context)
            newNote.text = note.text
            newNote.image = CacheManager.getImage()
            newNote.parentCategory = CacheManager.getCategory()
            notes.append(newNote)
        } else {
            guard let indexSelect = CacheManager.getIndex() else {return}
            notes[indexSelect - 1].text = note.text
            notes[indexSelect - 1].image = CacheManager.getImage()
        }
        saveItems()
        tableView.reloadData()
        for cell in tableView.visibleCells {
            (cell as? HomeTableViewCell)?.collectionView.reloadData()
        }
    }
    func addCollectionCell() {
        popupView.backgroundColor = UIColor(named: CacheManager.getImage() ?? "\(number)")
        animateIn(desiredView: blurView)
        animateIn(desiredView: popupView)
        note.text = CacheManager.getCache()
    }
    func deleteCategory() {
        DispatchQueue.main.async {
            self.loadCategories()
            self.tableView.reloadData()
        }
    }
       // MARK: - Animate View
    func animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        // Attach our desired view to the screen (backgroundView/self.view)
        //guard let backgroundView
        backgroundView.addSubview(desiredView)
        // Set the view scalling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = CGPoint(x: backgroundView.center.x, y: backgroundView.center.y - 120)
        // Animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    // Animate the specified the view
    func animateOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }) { _ in
            desiredView.removeFromSuperview()
        }
    }
    // MARK: - Model Manupulation Methods
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            category = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }
}
// MARK: - TableView Delegate and Datasource Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else { fatalError("Unable create cell") }
        cell.collectionView.contentOffset = .zero
        cell.titleTableCell.text = category[indexPath.row].title
        cell.category = category[indexPath.row]
        cell.delegate = self
//        cell.indexPath = indexPath
//        cell.indexCell = indexPath.row
        cell.collectionView.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  ViewController.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 13/10/20.
//
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var note: UITextView!
    var category: [String] = []
    var textNote: [String] = []
    var number = Int.random(in: 1...6)
    var indexCollectionSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set blur view
        blurView.bounds = self.view.bounds
        //Set popupView
        popupView.bounds = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

// MARK: - Add TablewViewCells - Category

    @IBAction func addTableCellPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            self.category.append(textField.text ?? "")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Add new Note
    @IBAction func doneButton(_ sender: Any) {
        animateOut(desiredView: popupView)
        animateOut(desiredView: blurView)
        textNote.append(note.text)
        for cell in tableView.visibleCells {
            (cell as? HomeTableViewCell)?.collectionView.reloadData()
        }
        tableView.reloadData()
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
}

// MARK: - TableView Delegate and Datasource Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else { fatalError("Unable create cell") }
        cell.titleTableCell.text = category[indexPath.row]
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.delegate = self
        //collectionViewHome = cell.collectionView
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
// MARK: - Collection View Delegate and Datasource

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textNote.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Unable create cell")
        }
        cell.imageBack.image = UIImage(named: "\(number)")
        cell.titleCollectionCell.text = textNote[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.0, height: 180.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexCollectionSelected = indexPath.row
        popupView.backgroundColor = UIColor(named: "\(number)")
        animateIn(desiredView: blurView)
        animateIn(desiredView: popupView)
    }
}
// MARK: - add Notes Methods
extension HomeViewController: CustomTableViewCellDelegate {
    func addCollectionCell() {
        popupView.backgroundColor = UIColor(named: "\(number)")
        animateIn(desiredView: blurView)
        animateIn(desiredView: popupView)
    }
}

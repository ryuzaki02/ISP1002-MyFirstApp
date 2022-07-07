//
//  CalculatorController.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import UIKit

class CalculatorController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var inputLabel: UILabel!
    
    let cellReuseIdentifier = "InputViewCollectionViewCell"
    var calculatorViewModel = CalculatorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Collection view setup method
    //
    private func setupCollectionView() {
        collectionView?.register(InputViewCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: - Collection view data source methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? InputViewCollectionViewCell {
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculatorViewModel.items.count
    }
    
}


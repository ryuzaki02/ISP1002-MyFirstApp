//
//  CalculatorController.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import UIKit

class CalculatorController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Iboutlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var inputLabel: UILabel!
    
    // Cell identifier
    let cellReuseIdentifier = "InputViewCollectionViewCell"
    // View model for controller intialised
    var calculatorViewModel = CalculatorViewModel()
    
    // MARK: - View life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorViewModel.delegate = self
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Collection view setup method
    //
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Collection view delegate methods
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Calculates action on numbers according to input
        calculatorViewModel.calculate(inputType: calculatorViewModel.items[indexPath.row], count: inputLabel.text?.count ?? 0)
    }
    
    // MARK: - Collection view data source methods
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! InputViewCollectionViewCell
        // Setup cell according to current item and view model
        cell.setupCell(item: calculatorViewModel.items[indexPath.row], viewModel: calculatorViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculatorViewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Provides custom height width according to device
        let size = (UIScreen.main.bounds.size.width - 85) / 4
        return CGSize(width: size, height: size)
    }
    
}

extension CalculatorController: CalculatorProtocol {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func updateInputLabel(value: String, append: Bool) -> String {
        if append {
            inputLabel.text?.append(value)
        } else {
            inputLabel.text = value
        }
        return inputLabel.text ?? ""
    }
}

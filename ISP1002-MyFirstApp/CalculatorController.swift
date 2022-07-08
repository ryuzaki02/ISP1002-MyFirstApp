//
//  CalculatorController.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import UIKit

class CalculatorController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var inputLabel: UILabel!
    
    let cellReuseIdentifier = "InputViewCollectionViewCell"
    var calculatorViewModel = CalculatorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Collection view setup method
    //
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let inputType = calculatorViewModel.items[indexPath.row]
//        if inputType.buttonType == .action {
//            calculatorViewModel.firstNumber = 0
//        } else if inputType.buttonType == .number {
//            if inputLabel.text?.isEmpty == true || inputLabel.text == "0" {
//                inputLabel.text = String(calculatorViewModel.firstNumber ?? 0)
//            } else {
//                inputLabel.text?.append(String(inputType.rawValue))
//            }
//            calculatorViewModel.firstNumber = Double(inputLabel.text ?? "") ?? 0
//        }
    }
    
    //MARK: - Collection view data source methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! InputViewCollectionViewCell
        cell.setupCell(item: calculatorViewModel.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculatorViewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.size.width - 85) / 4
        return CGSize(width: size, height: size)
    }
    
}


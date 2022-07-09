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
        let inputType = calculatorViewModel.items[indexPath.row]
        let currentAction = inputType.buttonType
        
        if inputType == .AC {
            inputLabel.text = "0"
            calculatorViewModel.reset()
            collectionView.reloadData()
            return
        } else if inputType == .equals {
            let output = calculatorViewModel.operate()
            inputLabel.text = calculatorViewModel.forTrailingZero(temp: output)
            collectionView.reloadData()
            return
        }
        
        if let lastAction = calculatorViewModel.lastAction {
            if let _ = calculatorViewModel.secondNumber {
                let output = calculatorViewModel.operate()
                inputLabel.text = calculatorViewModel.forTrailingZero(temp: output)
                collectionView.reloadData()
            }
            
            if lastAction == .number {
                calculatorViewModel.lastAction = currentAction
                if currentAction == .number && inputLabel.text?.count ?? 0 < 16 {
                    inputLabel.text?.append(inputType.rawValue)
                    calculatorViewModel.firstNumber = Double(inputLabel.text ?? "") ?? 0
                } else if currentAction == .operation {
                    calculatorViewModel.operation = inputType
                    if calculatorViewModel.isSingleOperation() {
                        calculatorViewModel.lastAction = .number
                        let output = calculatorViewModel.operate(singleOperation: true)
                        inputLabel.text = calculatorViewModel.forTrailingZero(temp: output)
                    }
                    collectionView.reloadData()
                }
            } else if lastAction == .operation {
                calculatorViewModel.lastAction = currentAction
                if currentAction == .number {
                    inputLabel.text = inputType.rawValue
                    calculatorViewModel.secondNumber = Double(inputLabel.text ?? "") ?? 0
                    collectionView.reloadData()
                }
            }
        } else {
            if currentAction == .operation {
                calculatorViewModel.lastAction = currentAction
                calculatorViewModel.firstNumber = 0
                calculatorViewModel.inputType = inputType
            } else if currentAction == .number {
                calculatorViewModel.lastAction = currentAction
                inputLabel.text = inputType.rawValue
                calculatorViewModel.firstNumber = Double(inputLabel.text ?? "") ?? 0
            }
        }
    }
    
    //MARK: - Collection view data source methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! InputViewCollectionViewCell
        cell.setupCell(item: calculatorViewModel.items[indexPath.row], viewModel: calculatorViewModel)
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


//
//  InputViewCollectionViewCell.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import UIKit

class InputViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var inputViewLabel: UILabel!
    @IBOutlet var parentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup Cell
    func setupCell(item: InputType, viewModel: CalculatorViewModel) {
        layer.cornerRadius = bounds.size.height / 2
        backgroundColor = item.buttonType == .number ? UIColor.lightGray : UIColor.orange
        inputViewLabel.textColor = .white
        inputViewLabel.text = item.rawValue
        if let operation = viewModel.operation,
           item == operation,
           let lastAction = viewModel.lastAction,
            lastAction == .operation {
            backgroundColor = .white
            inputViewLabel.textColor = .orange
        }
    }
    
}

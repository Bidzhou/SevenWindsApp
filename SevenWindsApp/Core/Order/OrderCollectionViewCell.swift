//
//  OrderCollectionViewCell.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 13.11.2024.
//

import UIKit



class OrderCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "OrderCollectionViewCell"
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "adfks"
        return label
    }()
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
    }
    
    private func createConstraints() {
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            nameLabel.widthAnchor.constraint(equalToConstant: 253)
        ]
        let countLabelConstraints = [
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14)
        ]
        
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(countLabelConstraints)
    }
}

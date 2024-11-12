//
//  TestCollectionViewCell.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 10.11.2024.
//

import UIKit

class ShopsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "testShit"
    
    let coffeShopNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SOME TEXT"
        label.font = UIFont.boldSystemFont(ofSize:18)
        label.textColor = UIColor.coffeShopsTheme.coffeShopTextColor
        return label
    }()
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some text too"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.coffeShopsTheme.secondaryTextColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(coffeShopNameLabel)
        contentView.addSubview(locationLabel)
        
        self.backgroundColor = UIColor.coffeShopsTheme.backgroundOfCoffeShop
        self.layer.cornerRadius = 5
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.white 
        self.selectedBackgroundView = selectedView
        
        NSLayoutConstraint.activate(
            [
                coffeShopNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                coffeShopNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                locationLabel.topAnchor.constraint(equalTo: coffeShopNameLabel.bottomAnchor, constant: 5),
                locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coffeShopName: String, and location: String) {
        
    }
}

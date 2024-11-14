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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize:18)
        label.textColor = UIColor.coffeShopsTheme.coffeShopTextColor
        label.text = "adfks"
        return label
    }()
    private let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minusDark"), for: .normal)
        button.addTarget(self, action: #selector(reduceCount), for: .touchDown)
        return button
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.coffeShopsTheme.secondaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
        
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plusDark"), for: .normal)
        button.addTarget(self, action: #selector(addCount), for: .touchDown)
        return button
    }()
    
    private let countLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor.coffeShopsTheme.coffeShopTextColor
        return label
    }()
    
    var onMinusButtonTapped: (() -> Void)!
    var onPlusButtonTapped: (() -> Void)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        createConstraints()
        self.backgroundColor = UIColor.coffeShopsTheme.backgroundOfCoffeShop
        self.layer.cornerRadius = 5
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.white
        self.selectedBackgroundView = selectedView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(plusButton)
    }
    
    private func createConstraints() {
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            nameLabel.widthAnchor.constraint(equalToConstant: 253)
        ]
        
        let priceLabelConstraints = [
            priceLabel.widthAnchor.constraint(equalToConstant: 94),
            priceLabel.heightAnchor.constraint(equalToConstant: 21),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6)
            
        ]
        
        
        let minusButtonConstraints = [
            minusButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 24),
            minusButton.heightAnchor.constraint(equalToConstant: 24),
            minusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        ]
        
        let countLabelConstraints = [
            countLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 9),
            countLabel.heightAnchor.constraint(equalToConstant: 19),
            countLabel.widthAnchor.constraint(equalToConstant: 10),
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27)
        ]
        
        let plusButtonConstraints = [
            plusButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 9),
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            plusButton.heightAnchor.constraint(equalToConstant: 24),
            plusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27)
            
            
        ]
        
        NSLayoutConstraint.activate(minusButtonConstraints)
        NSLayoutConstraint.activate(plusButtonConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(countLabelConstraints)
    }
    
    func cofigure(name: String, count: Int, price: Int) {
        self.nameLabel.text = name
        self.countLabel.text = "\(count)"
        self.priceLabel.text = "\(price)руб"
        
    }
    
    @objc func reduceCount() {
        guard let intCount = Int(countLabel.text ?? "0"), intCount >= 1 else {return}
        countLabel.text = "\(intCount - 1)"
        onMinusButtonTapped()
    }
    
    @objc func addCount() {
        guard let intCount = Int(countLabel.text ?? "0"), intCount < 9 else {return}
        countLabel.text = "\(intCount + 1)"

        onPlusButtonTapped()
    }
    
}

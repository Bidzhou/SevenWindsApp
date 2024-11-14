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
        label.font = UIFont.boldSystemFont(ofSize:18)
        label.textColor = UIColor.coffeShopsTheme.coffeShopTextColor
        label.text = "adfks"
        return label
    }()
    private let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minusSign"), for: .normal)
        button.addTarget(self, action: #selector(reduceCount), for: .touchDown)
        return button
    }()
    
//    private let priceLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.
//    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plusSign"), for: .normal)
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
        contentView.addSubview(plusButton)
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
    
    func cofigure(name: String, count: Int) {
        self.nameLabel.text = name
        self.countLabel.text = "\(count)"
        
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

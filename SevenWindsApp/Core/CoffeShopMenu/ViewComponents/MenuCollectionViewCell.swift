//
//  MenuCollectionViewCell.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    
    private var positionPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "asap")
        imageView.layer.cornerRadius = 5
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private let positionName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "Эспрессо"
        label.textColor = UIColor.coffeShopsTheme.secondaryTextColor
        label.numberOfLines = 1
        return label
    }()
    
    private let positionPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.coffeShopsTheme.coffeShopTextColor
        label.text = "312 руб"
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        contentView.addSubview(positionPhoto)
        contentView.addSubview(positionName)
        contentView.addSubview(positionPrice)
        createConstraints()
        
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createConstraints(){
        let positionNameConstraints = [
            positionName.topAnchor.constraint(equalTo: positionPhoto.bottomAnchor, constant: 11),
            positionName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            //positionName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            positionName.heightAnchor.constraint(equalToConstant: 18),
            positionName.widthAnchor.constraint(equalToConstant: 155)
        ]

        let positionPriceConstraints = [
            positionPrice.topAnchor.constraint(equalTo: positionName.bottomAnchor, constant: 11),
            positionPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            positionPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            positionPrice.heightAnchor.constraint(equalToConstant: 17),
            positionPrice.widthAnchor.constraint(equalToConstant: 155)
        ]

        let positionPhotoConstraints = [
            positionPhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            positionPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            positionPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            positionPhoto.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            positionPhoto.heightAnchor.constraint(equalToConstant: 137)
            // contentView.bounds.height - 15 - positionName.bounds.height - positionPrice.bounds.height
        ]

        NSLayoutConstraint.activate(positionPhotoConstraints)

        NSLayoutConstraint.activate(positionNameConstraints)
        NSLayoutConstraint.activate(positionPriceConstraints)


    }
    
    public func configure(name: String, price: Int, image: UIImage) {
        self.positionName.text = name
        self.positionPrice.text = "\(price) руб"
        self.positionPhoto.image = image
    }
    
    
}

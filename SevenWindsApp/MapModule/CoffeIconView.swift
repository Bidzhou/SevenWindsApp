//
//  CoffeIconView.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 17.11.2024.
//

import UIKit

class CoffeIconView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coffeIconBack") // Замените на ваше изображение
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cup.and.saucer") // Замените на ваше изображение
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш текст здесь"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configure(with text: String) {
        self.bottomLabel.text = text
    }
    
    private func setupView() {
        addSubview(backgroundImageView)
        addSubview(centerImageView)
        addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            // Расположение backgroundImageView
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            // Расположение centerImageView
            centerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerImageView.widthAnchor.constraint(equalToConstant: 17.5),
            centerImageView.heightAnchor.constraint(equalToConstant: 22.5),
            
            // Расположение bottomLabel
            bottomLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 9),
            bottomLabel.widthAnchor.constraint(equalToConstant: 90),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}




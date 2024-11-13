//
//  TestViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 12.11.2024.
//

import UIKit

class OrderViewController: UIViewController {

    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        return image
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "e-mail"
        label.textColor = UIColor.authTheme.labelText
        label.frame = CGRect(x: 10, y: 250, width: 100, height: 20)
        return label
        
    }()
    
    private let order: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailLabel)
        let networking = NetworkService()
        networking.getImage(url: "https://upload.wikimedia.org/wikipedia/commons/c/c6/Latte_art_3.jpg") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageView.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        }
        view.addSubview(imageView)
    }
    


}

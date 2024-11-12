//
//  TestViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 12.11.2024.
//

import UIKit

class TestViewController: UIViewController {

    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networking = NetworkService()
        let image = networking.getImage(url: "https://upload.wikimedia.org/wikipedia/commons/c/c6/Latte_art_3.jpg") { result in
            switch result {
                
            case .success(let img):
                self.imageView.image = img
            case .failure(let error):
                print(error)
            }
        }
        view.addSubview(imageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

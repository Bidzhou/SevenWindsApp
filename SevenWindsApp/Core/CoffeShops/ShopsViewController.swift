//
//  TestViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 10.11.2024.
//

import UIKit
protocol ShopsViewProtocol: AnyObject {
    func backButtonTapped()
    func mapButtonTouched()
    func successDownloadingData()
}


class ShopsViewController: UIViewController {
    
    var presenter: ShopsPresenterProtocol!
    let configurator = ShopsConfigurator()

    private let mapButton: UIButton =  {
        let button = UIButton()
        button.setTitle("На карте", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize:18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.authTheme.buttonText, for: .normal)
        button.backgroundColor = UIColor.authTheme.buttonBackground
        button.layer.borderColor = CGColor.authTheme.buttonBorder
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24.5
        button.addTarget(self, action: #selector(mapButtonTouched), for: .touchUpInside)
        return button
    }()
    
    let coffeShops: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ShopsCollectionViewCell.self, forCellWithReuseIdentifier: ShopsCollectionViewCell.identifier)
//        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(coffeShops)
        coffeShops.delegate = self
        coffeShops.dataSource = self
        view.addSubview(mapButton)
        createConstraints()
        setNavBar()
        configurator.configure(with: self)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coffeShops.layoutIfNeeded()
        
//        coffeShops.frame = CGRect(origin: CGPoint(x: 0, y: view.safeAreaInsets.top + 20), size: CGSize(width: view.bounds.width, height: view.bounds.height - 220))
        coffeShops.frame = view.bounds
        
        
    }
    
    private func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.authTheme.navBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.authTheme.labelText]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Ближайшие кофейни"
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = UIColor.authTheme.labelText
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func createConstraints() {
        let mapButtonConstraints = [
            mapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            mapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mapButton.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        NSLayoutConstraint.activate(mapButtonConstraints)
        
    }
    

}

extension ShopsViewController: ShopsViewProtocol {
    func successDownloadingData() {
        coffeShops.reloadData()
    }
    

    
    @objc func backButtonTapped() {
        presenter.goBack()
    }
    
    @objc func mapButtonTouched() {
        NetworkService().getLocations { result in
            switch result {
                
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error)
            }
        }
    }
}



extension ShopsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.coffeShops?.count ?? 0
    }
    
    
    //cell creation
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopsCollectionViewCell.identifier, for: indexPath) as? ShopsCollectionViewCell else {return UICollectionViewCell()}
        cell.coffeShopNameLabel.text = presenter.coffeShops?[indexPath.row].name ?? "Технические Шоколадки"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let coffeShop = presenter.coffeShops?[indexPath.row] else {return}
        presenter.goToTheCoffeShop(coffeShop)

        
    }
    
    

    
    
}

extension ShopsViewController: UICollectionViewDelegateFlowLayout {
    //отступы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
    }
    
    //длина и ширина
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Указываем отступы по бокам
        let horizontalInset: CGFloat = 10
        let itemWidth = collectionView.bounds.width - (horizontalInset * 2)
        let itemHeight: CGFloat = 71
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    //spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

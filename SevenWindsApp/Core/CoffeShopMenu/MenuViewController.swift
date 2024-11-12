//
//  MenuViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import UIKit
protocol MenuViewProtocol: AnyObject {
    var shop: CoffeShop? {get set}
    func success()
}


class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol!
    let configurator =  MenuConfigurator()
    var shop: CoffeShop? = nil
    let menu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 165, height: 205)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        return collectionView
    }()

    init(shop: CoffeShop) {
        self.shop = shop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.dataSource = self
        menu.delegate = self
        view.addSubview(menu)
        setNavBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configurator.configure(with: self)
        menu.frame = view.bounds
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
    
    @objc func backButtonTapped() {
        print("back")
    }
    
}

extension MenuViewController: MenuViewProtocol {
    
    
    
    func success() {
        menu.reloadData()
    }
}



extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.positions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {return UICollectionViewCell()}
        let name = presenter.positions?[indexPath.row].name ?? ""
        let price = presenter.positions?[indexPath.row].price ?? 0
        let url = presenter.positions?[indexPath.row].imageURL ?? ""
        presenter.getImage(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    cell.configure(name: name, price: price, image: image)
                case .failure(let error):
                    print("error")
                }
            }

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellsWidth: CGFloat = 165 * 2
        let sideInset: CGFloat = (collectionView.bounds.width - cellsWidth) / 3

        return UIEdgeInsets(top: 10, left: sideInset, bottom: 10, right: sideInset)
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}



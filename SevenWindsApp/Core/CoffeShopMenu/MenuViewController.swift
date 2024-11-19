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
    func payButtonTapped()
}


class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol!
    let configurator =  MenuConfigurator()
    var shop: CoffeShop? = nil
    var cacheImages: [Int: UIImage] = [:]
    private let payButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Перейти к оплате", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize:18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.authTheme.buttonText, for: .normal)
        button.backgroundColor = UIColor.authTheme.buttonBackground
        button.layer.borderColor = CGColor.authTheme.buttonBorder
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24.5
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
        configurator.configure(with: self)
        menu.dataSource = self
        menu.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(updatePositions(_:)), name: NSNotification.Name("OrderUpdated"), object: nil)

        view.addSubview(menu)
        view.addSubview(payButton)
        createConstraints()
        setNavBar()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        let newView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: view.safeAreaInsets.top + 20), size: CGSize(width: view.bounds.width, height: view.bounds.height - 120)))
//        menu.frame = newView.bounds
        menu.frame = view.bounds
    }
    @objc func updatePositions(_ notification: Notification) {
        if let order = notification.userInfo?["positions"] as? [Position] {
            guard var positions = presenter.positions else {return}
            presenter.updatePositionCount(order: order, positions: &positions)
            presenter.positions = positions
            menu.reloadData()
        }
    }
    
    private func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.authTheme.navBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.authTheme.labelText]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Меню"
        
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
        presenter.goBack()
    }
    
    private func createConstraints() {
        let payButtonConstraints = [
            payButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            payButton.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        NSLayoutConstraint.activate(payButtonConstraints)
        
    }
    
}

extension MenuViewController: MenuViewProtocol {
    @objc func payButtonTapped() {
        presenter.goPay()
    }
    
    
    
    
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
        let count = presenter.positions?[indexPath.row].count ?? 0
        guard let id = presenter.positions?[indexPath.row].id else {return UICollectionViewCell()}
        
        cell.onMinusButtonTapped = { [weak self] in
            self?.presenter.onMinusButtonTapped(index: indexPath.row)
        }
        cell.onPlusButtonTapped = { [weak self] in
            self?.presenter.onPlusButtonTapped(index: indexPath.row)
        }
        if cacheImages.contains(where: {$0.key == id}) {
            if let image = cacheImages[id] {
                cell.setImage(image: image)
            } else {
                cell.setImage(image: UIImage(systemName: "asap")!)
            }
        } else {
            self.presenter.getImage(url: url) {[weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        cell.setImage(image: image)
                        //guard let id = self?.presenter.positions?[indexPath.row].id else {return}
                        self?.cacheImages.updateValue(image, forKey: id)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

            }
        }

        
        cell.configure(name: name, price: price,count: count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellsWidth: CGFloat = 165 * 2
        let sideInset: CGFloat = (collectionView.bounds.width - cellsWidth) / 3

        return UIEdgeInsets(top: 20, left: sideInset, bottom: 10, right: sideInset)
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    
    
}



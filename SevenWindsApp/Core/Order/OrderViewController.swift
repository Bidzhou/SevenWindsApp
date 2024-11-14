//
//  TestViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 12.11.2024.
//

import UIKit
protocol OrderViewProtocol: AnyObject {
    func backButtonTapped()
    func orderButtonTapped()
    func success()
    var orderPositions: [Position]? {get set}
}


class OrderViewController: UIViewController {
    var orderPositions:[Position]? = nil
    var presenter: OrderPresenterProtocol!
    let configurator = OrderConfigurator()
    
    private let order: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
        return collectionView
    }()
    
    init(order: [Position]) {
        self.orderPositions = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        order.delegate = self
        order.dataSource = self
        configure()
        view.addSubview(order)
        setNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        order.frame = view.bounds
        
    }
    
    func configure() {
        self.configurator.configure(with: self)
        self.presenter.order = orderPositions
        print(orderPositions?.debugDescription)
        success()
        
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
    


}


extension OrderViewController: OrderViewProtocol {
    @objc func backButtonTapped() {
        presenter.goBack()

    }
    
    func orderButtonTapped() {
        print("order Tapped")
    }
    
    func success() {
        order.reloadData()
    }
    
}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.order?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as? OrderCollectionViewCell else {return UICollectionViewCell()}
        let name = presenter.order?[indexPath.row].name ?? "s"
        let count = presenter.order?[indexPath.row].count ?? 123222
        cell.cofigure(name: name, count: count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
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



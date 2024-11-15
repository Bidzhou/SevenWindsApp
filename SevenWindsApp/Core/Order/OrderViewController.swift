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
    
    private let orderButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Перейти к оплате", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize:18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.authTheme.buttonText, for: .normal)
        button.backgroundColor = UIColor.authTheme.buttonBackground
        button.layer.borderColor = CGColor.authTheme.buttonBorder
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24.5
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return button
    }()

    
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
        view.addSubview(order)
        view.addSubview(orderButton)
        configure()
        createConstraints()
        
        setNavBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        order.frame = view.bounds
        
        
    }
    
    func configure() {
        self.configurator.configure(with: self)
        self.presenter.order = orderPositions
        
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
    
    private func createConstraints() {
        let orderButtonConstraints = [orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                                      orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                      orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                      orderButton.heightAnchor.constraint(equalToConstant: 48)]
        NSLayoutConstraint.activate(orderButtonConstraints)
    }


}


extension OrderViewController: OrderViewProtocol {
    @objc func backButtonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("OrderUpdated"), object: nil, userInfo: ["positions": presenter.order ?? []])
        presenter.goBack()


    }
    
    @objc func orderButtonTapped() {
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
        let price = presenter.order?[indexPath.row].price ?? 0
        
        cell.onMinusButtonTapped = { [weak self] in
            self?.presenter.onMinusButtonTapped(index: indexPath.row)
        }
        
        cell.onPlusButtonTapped = { [weak self] in
            self?.presenter.onPlusButtonTapped(index: indexPath.row)
        }
        
        cell.cofigure(name: name, count: count, price: price)
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



//
//  TestViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 10.11.2024.
//

import UIKit
import CoreLocation

protocol ShopsViewProtocol: AnyObject {
    func backButtonTapped()
    func mapButtonTouched()
    func successDownloadingData()
    func addButtonTargets()
    func mapButtonTouchUpInside()
    func mapButtonTouchDown()
    func buttonUnpushAnimation(button: UIButton)
    func buttonPushAnimation(button: UIButton)
}


class ShopsViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
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
        return button
    }()
    
    let coffeShops: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ShopsCollectionViewCell.self, forCellWithReuseIdentifier: ShopsCollectionViewCell.identifier)
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
        setLocationService()
        configurator.configure(with: self)
        addButtonTargets()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coffeShops.layoutIfNeeded()
        
//        coffeShops.frame = CGRect(origin: CGPoint(x: 0, y: view.safeAreaInsets.top + 20), size: CGSize(width: view.bounds.width, height: view.bounds.height - 220))
        coffeShops.frame = view.bounds
        
        
    }
    
    private func setLocationService() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    func addButtonTargets() {
        mapButton.addTarget(self, action: #selector(mapButtonTouched), for: .touchUpInside)
        mapButton.addTarget(self, action: #selector(mapButtonTouchDown), for: .touchDown)
        mapButton.addTarget(self, action: #selector(mapButtonTouchUpInside), for: .touchUpOutside)
    }
    
    func buttonPushAnimation(button: UIButton){
        UIView.animate(withDuration: 0.1, animations: {button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9 )})
    }
    
    func buttonUnpushAnimation(button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {button.transform = .identity})
    }
    
    func successDownloadingData() {
        coffeShops.reloadData()
    }

    @objc func backButtonTapped() {
        presenter.goBack()
    }
    
    @objc func mapButtonTouched() {
        buttonUnpushAnimation(button: mapButton)
        guard currentLocation != nil else {return}
        guard presenter.locations != nil else {return}
        presenter.showOnMaps(currentLocation: currentLocation!, shops: presenter.coffeShops ?? [])
    }
    
    @objc func mapButtonTouchDown() {
        buttonPushAnimation(button: mapButton)
    }
    
    @objc func mapButtonTouchUpInside(){
        buttonUnpushAnimation(button: mapButton)
    }
}



extension ShopsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("No location available")
            return
        }
        print("Location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        currentLocation = location
        coffeShops.reloadData()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
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
        let name = presenter.coffeShops?[indexPath.row].name ?? "Технические Шоколадки"
        let location = presenter.locations?[indexPath.row] ?? CLLocation(latitude: 55.7558, longitude: 37.6173)
        let distance = presenter.formatDistance((currentLocation?.distance(from: location) ?? 0.0))
        
        cell.configure(with: name, and: distance)
       
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

//
//  MapViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 16.11.2024.
//

import UIKit
import CoreLocation
import YandexMapsMobile

protocol MapViewProtocol: AnyObject {
    func createCustomImage(with text: String) -> UIImage
}

class MapViewController: UIViewController {
    private var shops: [CoffeShop]? = nil
    private var currentLocation: CLLocation? = nil
    
    var presenter: MapPresenterProtocol!
    private let configurator = MapConfigurator()

    let mapView: YMKMapView = {
        let map = YMKMapView(frame: .zero, vulkanPreferred: true)
        return map!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setNavBar()
        view.addSubview(mapView)
        zoomToFirst()
        addPlacemarks()

    }
    
    init(currentLocation: CLLocation, shops: [CoffeShop]) {
        self.currentLocation = currentLocation
        self.shops = shops
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    private func zoomToFirst() {
        guard shops != nil else {return}
        guard currentLocation != nil else {return}
        guard let location = presenter.getClosestShop(location: currentLocation!, shops: shops!) else {return}
         
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                zoom: 12,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.linear, duration: 1),
            cameraCallback: nil
        )
    }
    
    
    private func addPlacemarks() {
        guard shops != nil else {return}
        for shop in shops! {
            guard let latitude = Double(shop.point.latitude) else {continue}
            guard let longitude = Double(shop.point.longitude) else {continue}
            let placemark = mapView.mapWindow.map.mapObjects.addPlacemark()
            placemark.geometry = YMKPoint(latitude: latitude, longitude: longitude)
            let image = createCustomImage(with: shop.name)
            placemark.setIconWith(image)
            placemark.userData = shop
            placemark.addTapListener(with: self)
            
        }

    }
    

    
    private func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.authTheme.navBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.authTheme.labelText]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Карта"
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = UIColor.authTheme.labelText
        navigationItem.leftBarButtonItem = backButton
        
    }

    
    


    @objc private func backButtonTapped() {
        presenter.goBack()
    }
}



extension MapViewController: MapViewProtocol{
    //icon
     func createCustomImage(with text: String) -> UIImage {
       
        let circleDiameter: CGFloat = 58
        let textWidth: CGFloat = 90
        let textFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        let textMaxLines: Int = 3
        let textPadding: CGFloat = 4

//         Расчет размера текста
        let textBoundingRect = text.boundingRect(
            with: CGSize(width: textWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: textFont],
            context: nil
        )

        // Ограничение высоты текста
        let lineHeight = textFont.lineHeight
        let maxTextHeight = lineHeight * CGFloat(textMaxLines)
        let textHeight = min(textBoundingRect.height, maxTextHeight)
        let totalHeight = circleDiameter + textPadding + textHeight

        //изображение
        let size =  CGSize(width: max(circleDiameter, textWidth), height: totalHeight)
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { context in
            //круг
            let circleRect = CGRect(x: (size.width - circleDiameter) / 2, y: 0, width: circleDiameter, height: circleDiameter)
            UIColor.authTheme.buttonBackground.setFill()
            context.cgContext.fillEllipse(in: circleRect)

            //иконка в центре круга
            let icon = UIImage(named: "tabler_cup")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            let iconSize = CGSize(width: 17.6, height: 22.5)
            let iconOrigin = CGPoint(x: circleRect.midX - iconSize.width / 2, y: circleRect.midY - iconSize.height / 2)
            icon?.draw(in: CGRect(origin: iconOrigin, size: iconSize))

            //текст
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            

            let attributes: [NSAttributedString.Key: Any] = [
                .font: textFont,
                .foregroundColor: UIColor.coffeShopsTheme.coffeShopTextColor,
                .paragraphStyle: paragraphStyle
                 
            ]

            let textRect = CGRect(
                x: 0,
                y: circleDiameter + textPadding,
                width: textWidth,
                height: totalHeight
            )
            text.draw(in: textRect, withAttributes: attributes)
        }
    }
}

//MapObjectTapListener
extension MapViewController: YMKMapObjectTapListener {


    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool 
    {
        //print(mapObject.description)
        if let placemark = mapObject as? YMKPlacemarkMapObject,
            let shop = placemark.userData as? CoffeShop {
            presenter.goToCoffeShop(shop: shop)
            
        }
        return true
    }

}

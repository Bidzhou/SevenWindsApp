//
//  MapViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 16.11.2024.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class MapViewController: UIViewController {
    var locations: [CLLocation]? = nil
    var currentLocation: CLLocation? = nil
    let mapView: YMKMapView = {
        let map = YMKMapView(frame: .zero, vulkanPreferred: true)
        return map!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        zoomToFirst()
        addPlacemarks()

    }
    
    init(currentLocation: CLLocation, locations: [CLLocation]) {
        self.currentLocation = currentLocation
        self.locations = locations
        
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
        guard locations != nil else {return}
        guard let location = locations?.first else {return}
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 3),
            cameraCallback: nil
        )
    }
    
    private func addPlacemarks() {
        guard locations != nil else {return}
        for location in locations! {
            let image = UIImage(named: "coffeIcon") ?? UIImage()
            let placemark = mapView.mapWindow.map.mapObjects.addPlacemark()
            placemark.geometry = YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            placemark.setIconWith(image)
        }

    }
    

}

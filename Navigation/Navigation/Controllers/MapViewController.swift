//
//  MapViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 30.04.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private var model: MapModel
    private lazy var locationManager = CLLocationManager()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private let standartMap = CustomButton(title: "Стандарт", backgroundColor: .systemGray)
    private let satelliteMap = CustomButton(title: "Спутник", backgroundColor: .systemGray)
    private let hybridMap = CustomButton(title: "Гибрид", backgroundColor: .systemGray)
    private let deletePins = CustomButton(title: "Убрать метки", backgroundColor: .systemGray)
    private let addRoute = CustomButton(title: "Проложить маршрут", backgroundColor: .systemGray)
    private lazy var myAnnotations = [MKPointAnnotation]()
    private lazy var myWaypoints = [CLLocation]()
    private lazy var pointOfDestination = CLLocationCoordinate2D()
    
    init(model: MapModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = model.title
        view.backgroundColor = model.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        findUserLocation()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(addWaypoint(longGesture:)))
        mapView.addGestureRecognizer(longGesture)
        longGesture.minimumPressDuration = 2.0
    }
    
    private func findUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    private func setupMapView() {
        standartMap.tapAction = { self.standardMapType() }
        satelliteMap.tapAction = { self.satelliteMapType() }
        hybridMap.tapAction = { self.hybridMapType() }
        deletePins.tapAction = { self.clearPins() }
        addRoute.tapAction = { self.calculateRoute() }
        
        [mapView, standartMap, satelliteMap, hybridMap, deletePins, addRoute].forEach { view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            standartMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            standartMap.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            standartMap.heightAnchor.constraint(equalToConstant: 30),
            standartMap.widthAnchor.constraint(equalToConstant: 140),
            
            satelliteMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            satelliteMap.leadingAnchor.constraint(equalTo: standartMap.trailingAnchor, constant: 1),
            satelliteMap.heightAnchor.constraint(equalToConstant: 30),
            satelliteMap.widthAnchor.constraint(equalToConstant: 140),
            
            hybridMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            hybridMap.leadingAnchor.constraint(equalTo: satelliteMap.trailingAnchor, constant: 1),
            hybridMap.heightAnchor.constraint(equalToConstant: 30),
            hybridMap.widthAnchor.constraint(equalToConstant: 140),
            
            deletePins.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -4),
            deletePins.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -4),
            deletePins.heightAnchor.constraint(equalToConstant: 30),
            deletePins.widthAnchor.constraint(equalToConstant: 140),
            
            addRoute.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -4),
            addRoute.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 4),
            addRoute.heightAnchor.constraint(equalToConstant: 30),
            addRoute.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc private func standardMapType() {
        mapView.mapType = .standard
    }
    
    @objc private func satelliteMapType() {
        mapView.mapType = .satellite
    }
    
    @objc private func hybridMapType() {
        mapView.mapType = .hybrid
    }
    
    @objc private func clearPins() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    @objc private func addWaypoint(longGesture: UIGestureRecognizer) {
        
        let touchPoint = longGesture.location(in: mapView)
        let wayCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)
        pointOfDestination = location.coordinate
        
        let wayAnnotation = MKPointAnnotation()
        wayAnnotation.coordinate = wayCoords
        wayAnnotation.title = "waypoint"
        myAnnotations.append(wayAnnotation)
        mapView.addAnnotation(wayAnnotation)
        print(myAnnotations)
    }
    
    @objc private func calculateRoute() {
        let coord1 = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0 , longitude: locationManager.location?.coordinate.longitude ?? 0 )
        let coord2 = pointOfDestination
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: coord1, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coord2, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        // Высчитываем путь
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error -> Void in
            guard let self = self else {
                return
            }
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.delegate = self
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            mapView.setCenter(location.coordinate, animated: true)
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 100_000,
                longitudinalMeters: 100_000)
            
            mapView.setRegion(region, animated: false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle failure to get a user’s location
    }
}

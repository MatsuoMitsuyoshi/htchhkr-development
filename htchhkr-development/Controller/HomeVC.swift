//
//  HomeVC.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/20.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RevealingSplashView

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    
    var delegate: CenterVCDelegate?
    
    var manager: CLLocationManager?
    
    var regionRadius: CLLocationDistance = 1000
    
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest

        checkLocationAuthStatus()
        
        mapView.delegate = self
        
        centerMapOnUserLocation()
        
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
    }
    
    func checkLocationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            manager?.startUpdatingLocation()
        } else {
            manager?.requestAlwaysAuthorization()
        }
    }
    
    func centerMapOnUserLocation() {
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animaiteButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func centerMapBtnWasPressed(_ sender: Any) {
        centerMapOnUserLocation()
    }
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
    
}

extension HomeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}

extension HomeVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        UpdateService.instance.updateUserLocation(withCoordinate: userLocation.coordinate)
        UpdateService.instance.updateDriverLocation(withCoordinate: userLocation.coordinate)
        
//        if currentUserId != nil {
//            DataService.instance.userIsDriver(userKey: currentUserId!) { (isDriver) in
//                if isDriver == true {
//                    DataService.instance.driverIsOnTrip(driverKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//                        if isOnTrip == true {
//                            self.zoom(toFitAnnotationsFromMapView: self.mapView, forActiveTripWithDriver: true, withKey: driverKey)
//                        } else {
//                            self.centerMapOnUserLocation()
//                        }
//                    })
//                } else {
//                    DataService.instance.passengerIsOnTrip(passengerKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//                        if isOnTrip == true {
//                            self.zoom(toFitAnnotationsFromMapView: self.mapView, forActiveTripWithDriver: true, withKey: driverKey)
//                        } else {
//                            self.centerMapOnUserLocation()
//                        }
//                    })
//                }
//            }
//        }
//    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let identifier = "driver"
            var view: MKAnnotationView
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "driverAnnotation")
            return view
//        } else if let annotation = annotation as? PassengerAnnotation {
//            let identifier = "passenger"
//            var view: MKAnnotationView
//            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.image = UIImage(named: ANNO_PICKUP)
//            return view
//        } else if let annotation = annotation as? MKPointAnnotation {
//            let identifier = "destination"
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            if annotationView == nil {
//                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            } else {
//                annotationView?.annotation = annotation
//            }
//            annotationView?.image = UIImage(named: ANNO_DESTINATION)
//            return annotationView
        }
        return nil
    }

//    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        centerMapBtn.fadeTo(alphaValue: 1.0, withDuration: 0.2)
//    }
//
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let lineRenderer = MKPolylineRenderer(overlay: (self.route?.polyline)!)
//        lineRenderer.strokeColor = UIColor(red: 216/255, green: 71/255, blue: 30/255, alpha: 0.75)
//        lineRenderer.lineWidth = 3
//
//        shouldPresentLoadingView(false)
//
//        return lineRenderer
//    }
//
//    func performSearch() {
//        matchingItems.removeAll()
//        let request = MKLocalSearchRequest()
//        request.naturalLanguageQuery = destinationTextField.text
//        request.region = mapView.region
//
//        let search = MKLocalSearch(request: request)
//
//        search.start { (response, error) in
//            if error != nil {
//                self.showAlert(ERROR_MSG_UNEXPECTED_ERROR)
//            } else if response!.mapItems.count == 0 {
//                self.showAlert(ERROR_MSG_NO_MATCHES_FOUND)
//            } else {
//                for mapItem in response!.mapItems {
//                    self.matchingItems.append(mapItem as MKMapItem)
//                    self.tableView.reloadData()
//                    self.shouldPresentLoadingView(false)
//                }
//            }
//        }
//    }
//
//    func dropPinFor(placemark: MKPlacemark) {
//        selectedItemPlacemark = placemark
//
//        for annotation in mapView.annotations {
//            if annotation.isKind(of: MKPointAnnotation.self) {
//                mapView.removeAnnotation(annotation)
//            }
//        }
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = placemark.coordinate
//        mapView.addAnnotation(annotation)
//    }
//
//    func searchMapKitForResultsWithPolyline(forOriginMapItem originMapItem: MKMapItem?, withDestinationMapItem destinationMapItem: MKMapItem) {
//        let request = MKDirectionsRequest()
//
//        if originMapItem == nil {
//            request.source = MKMapItem.forCurrentLocation()
//        } else {
//            request.source = originMapItem
//        }
//
//        request.destination = destinationMapItem
//        request.transportType = MKDirectionsTransportType.automobile
//        request.requestsAlternateRoutes = true
//
//        let directions = MKDirections(request: request)
//
//        directions.calculate { (response, error) in
//            guard let response = response else {
//                self.showAlert(error.debugDescription)
//                return
//            }
//            self.route = response.routes[0]
//
//            self.mapView.add(self.route!.polyline)
//
//            self.zoom(toFitAnnotationsFromMapView: self.mapView, forActiveTripWithDriver: false, withKey: nil)
//
//            let delegate = AppDelegate.getAppDelegate()
//            delegate.window?.rootViewController?.shouldPresentLoadingView(false)
//        }
//    }
//
//    func zoom(toFitAnnotationsFromMapView mapView: MKMapView, forActiveTripWithDriver: Bool, withKey key: String?) {
//        if mapView.annotations.count == 0 {
//            return
//        }
//
//        var topLeftCoordinate = CLLocationCoordinate2D(latitude: -90, longitude: 180)
//        var bottomRightCoordinate = CLLocationCoordinate2D(latitude: 90, longitude: -180)
//
//
//        if forActiveTripWithDriver {
//            for annotation in mapView.annotations {
//                if let annotation = annotation as? DriverAnnotation {
//                    if annotation.key == key {
//                        topLeftCoordinate.longitude = fmin(topLeftCoordinate.longitude, annotation.coordinate.longitude)
//                        topLeftCoordinate.latitude = fmax(topLeftCoordinate.latitude, annotation.coordinate.latitude)
//                        bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, annotation.coordinate.longitude)
//                        bottomRightCoordinate.latitude = fmin(bottomRightCoordinate.latitude, annotation.coordinate.latitude)
//                    }
//                } else {
//                    topLeftCoordinate.longitude = fmin(topLeftCoordinate.longitude, annotation.coordinate.longitude)
//                    topLeftCoordinate.latitude = fmax(topLeftCoordinate.latitude, annotation.coordinate.latitude)
//                    bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, annotation.coordinate.longitude)
//                    bottomRightCoordinate.latitude = fmin(bottomRightCoordinate.latitude, annotation.coordinate.latitude)
//                }
//            }
//        }
//
//
//        for annotation in mapView.annotations where !annotation.isKind(of: DriverAnnotation.self) {
//            topLeftCoordinate.longitude = fmin(topLeftCoordinate.longitude, annotation.coordinate.longitude)
//            topLeftCoordinate.latitude = fmax(topLeftCoordinate.latitude, annotation.coordinate.latitude)
//            bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, annotation.coordinate.longitude)
//            bottomRightCoordinate.latitude = fmin(bottomRightCoordinate.latitude, annotation.coordinate.latitude)
//        }
//
//        var region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(topLeftCoordinate.latitude - (topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 0.5, topLeftCoordinate.longitude + (bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 0.5), span: MKCoordinateSpan(latitudeDelta: fabs(topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 2.0, longitudeDelta: fabs(bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 2.0))
//
//        region = mapView.regionThatFits(region)
//        mapView.setRegion(region, animated: true)
//    }
//
//    func removeOverlaysAndAnnotations(forDrivers: Bool?, forPassengers: Bool?) {
//
//        for annotation in mapView.annotations {
//            if let annotation = annotation as? MKPointAnnotation {
//                mapView.removeAnnotation(annotation)
//            }
//
//            if forPassengers! {
//                if let annotation = annotation as? PassengerAnnotation {
//                    mapView.removeAnnotation(annotation)
//                }
//            }
//
//            if forDrivers! {
//                if let annotation = annotation as? DriverAnnotation {
//                    mapView.removeAnnotation(annotation)
//                }
//            }
//        }
//
//        for overlay in mapView.overlays {
//            if overlay is MKPolyline {
//                mapView.remove(overlay)
//            }
//        }
//    }
//
//    func setCustomRegion(forAnnotationType type: AnnotationType, withCoordinate coordinate: CLLocationCoordinate2D) {
//        if type == .pickup {
//            let pickupRegion = CLCircularRegion(center: coordinate, radius: 100, identifier: REGION_PICKUP)
//            manager?.startMonitoring(for: pickupRegion)
//        } else if type == .destination {
//            let destinationRegion = CLCircularRegion(center: coordinate, radius: 100, identifier: REGION_DESTINATION)
//            manager?.startMonitoring(for: destinationRegion)
//        }
    }
}


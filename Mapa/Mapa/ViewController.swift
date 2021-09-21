//
//  ViewController.swift
//  Mapa
//
//  Created by Gabriela Sillis on 21/09/21.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.centerToLocation(location: initLocation())
        configureMapZoom()
        configureArtwork()
    }

    private func initLocation() -> CLLocation {
        return CLLocation(latitude: 21.282778, longitude: -157.829444)
    }

    private func configureMapZoom() {
        let centerLocation = CLLocation(latitude: 21.4765, longitude: -157.9647)

        let region = MKCoordinateRegion(center: centerLocation.coordinate, latitudinalMeters: 50000, longitudinalMeters: 60000)

        mapView.setCameraBoundary(MKMapView.CameraBoundary.init(coordinateRegion: region), animated: true)

        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }

    private func configureArtwork() {
        let artwork = Artwork(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))

        mapView.addAnnotation(artwork)
    }
}

private extension MKMapView {

    func centerToLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {

        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)

        setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
     func mapView(_ mapview: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else {
            return nil
        }

        let identifier = "artwork"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapview.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView

        } else {

            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}


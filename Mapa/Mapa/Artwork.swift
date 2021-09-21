//
//  Artwork.swift
//  Mapa
//
//  Created by Gabriela Sillis on 21/09/21.
//

import Foundation
import MapKit

// MKAnnotation is an NSObjectProtocol
class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let discipline: String?

    // MKAnnotation requires the coordinate property
    let coordinate: CLLocationCoordinate2D

    init(title: String?, locationName: String?, discipline: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate

        super.init()
    }

    var subtitle: String?  {
        return locationName
    }
}

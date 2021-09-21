//
//  Artwork.swift
//  Mapa
//
//  Created by Gabriela Sillis on 21/09/21.
//

import Foundation
import MapKit

// it's a framework using to set the address, city or state fields of a location
import Contacts

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

    init?(feature: MKGeoJSONFeature) {
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
        else {
            return nil
        }

        title = properties["title"] as? String
        locationName = properties["location"] as? String
        discipline = properties["discipline"] as? String
        coordinate = point.coordinate

        super.init()
    }

    var subtitle: String?  {
        return locationName
    }

    var mapItem: MKMapItem? {
        guard let location = locationName else {
            return nil
        }

        let addressDict = [CNPostalAddressStateKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title

        return mapItem
    }
}

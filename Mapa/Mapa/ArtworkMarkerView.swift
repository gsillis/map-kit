//
//  ArtworkMarkerView.swift
//  Mapa
//
//  Created by Gabriela Sillis on 21/09/21.
//

import MapKit

class ArtworkMarkerView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {
                return
            }

            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            image = artwork.image

            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 46)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            rightCalloutAccessoryView = mapsButton

            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = artwork.subtitle
            detailCalloutAccessoryView = detailLabel

        }
    }
}


//  Created by SinaMN75 on 10/25/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import MapKit

class MapKitViewController: UIViewController, MKMapViewDelegate {
    
    var coordinate2D = CLLocationCoordinate2D(latitude: 35.694613, longitude: 51.249729)
    var coordinate2D2 = CLLocationCoordinate2D(latitude: 35.698197, longitude: 51.265555)
    var camera = MKMapCamera()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
                
        
        
        mapView.updateCamera(coordinate2D: coordinate2D, altitude: 100)
        mapView.mapType = .standard
        
        mapView.addAnnotation(coordinate: coordinate2D,
                              title: "hello",
                              subtitle: "bye",
                              leftDetail: UIImageView(image: UIImage(named: "ir")),
                              rightDetail: UIImageView(image: UIImage(named: "ir")),
                              overlayRadius: 100)
        
        mapView.addCircleOverlay(coordinate: coordinate2D2, radius: 100)
        
        mapView.addPolyline(points: [coordinate2D, coordinate2D2])
        
        
        requestLocationPermission()
        
        mapView.setup()
        
        getAddress(coordinates: coordinate2D)
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKPinAnnotationView()
        guard let annotation = annotation as? AnnotationMapKit else { return nil}
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifire) as? MKPinAnnotationView {
            annotationView = dequedView
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifire)
        }
        
        annotationView.image = UIImage(named: "ir")
        annotationView.canShowCallout = true // by default it's turned off, so nothing will show at the annotations.
        
        let paragraph = UILabel()
        paragraph.numberOfLines = 0
        paragraph.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        paragraph.textColor = .red
        paragraph.text = annotation.title
        
        annotationView.leftCalloutAccessoryView = annotation.leftDetail
        annotationView.rightCalloutAccessoryView = annotation.rightDetail
        annotationView.detailCalloutAccessoryView = paragraph
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(polyline: polyline)
            polylineRenderer.fillColor = .red
            polylineRenderer.strokeColor = .blue
            polylineRenderer.lineWidth = 10
            polylineRenderer.lineDashPattern = [20, 10, 2, 10]
            polylineRenderer.alpha = 0.7
            return polylineRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

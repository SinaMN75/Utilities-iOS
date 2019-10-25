//  Created by SinaMN75 on 10/25/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import MapKit

class AnnotationMapKit: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String?
    var overlayRadius: Double?
    var identifire = "pin"
    var leftDetail: UIView?
    var rightDetail: UIView?
    
    init(coordinate: CLLocationCoordinate2D,
         title: String?,
         subtitle: String? = nil,
         leftDetail: UIView? = nil,
         rightDetail: UIView? = nil,
         overlayRadius: Double? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.leftDetail = leftDetail
        self.rightDetail = rightDetail
        self.overlayRadius = overlayRadius
    }
}

extension MKMapView {
    func setup(showsPointsOfInterest: Bool = true,
               showsBuildings: Bool = true,
               showsScale: Bool = true,
               showsCompass: Bool = true,
               showsTraffic: Bool = true,
               showsUserLocation: Bool = true) {
        self.showsPointsOfInterest = showsPointsOfInterest
        self.showsBuildings = showsBuildings
        self.showsScale = showsScale
        self.showsCompass = showsCompass
        self.showsTraffic = showsTraffic
        self.showsUserLocation = showsUserLocation
        if showsUserLocation { self.setUserTrackingMode(.follow, animated: true) }
    }
    
    func updateRegion(_ coordinate2D: CLLocationCoordinate2D, range: CLLocationDistance = 100) {
        self.region = MKCoordinateRegion.init(center: coordinate2D, latitudinalMeters: range, longitudinalMeters: range)
    }
    
    func updateCamera(coordinate2D: CLLocationCoordinate2D, altitude: Double, heading: Double = 0.0, pitch: Double = 0.0) {
        let camera = MKMapCamera()
        camera.centerCoordinate = coordinate2D
        camera.altitude = altitude
        camera.heading = heading
        camera.pitch = CGFloat(pitch)
        self.camera = camera
    }
    
    // MARK: - ANNOTATIONS
    /**
     must implement viewFor in the used ViewController.
     
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     var annotationView = MKPinAnnotationView()
     guard let annotation = annotation as? AnnotationMapKit else { return nil}
     if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifire) as? MKPinAnnotationView {
     annotationView = dequedView
     } else { annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifire) }
     
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
     
     To use the overlay radius:
     
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
     if let circle = overlay as? MKCircle {
     let circleRenderer = MKCircleRenderer(circle: circle)
     circleRenderer.fillColor = .red
     circleRenderer.strokeColor = .blue
     circleRenderer.lineWidth = 1
     circleRenderer.alpha = 0.3
     return circleRenderer
     }
     return MKOverlayRenderer(overlay: overlay)
     }
     */
    
    func addAnnotation(coordinate: CLLocationCoordinate2D,
                       title: String,
                       subtitle: String? = nil,
                       leftDetail: UIView? = nil,
                       rightDetail: UIView? = nil,
                       overlayRadius: Double? = nil) {
        let pin = AnnotationMapKit(coordinate: coordinate,
                                   title: title,
                                   subtitle: subtitle,
                                   leftDetail: leftDetail,
                                   rightDetail: rightDetail,
                                   overlayRadius: overlayRadius)
        self.addAnnotation(pin)
        self.addOverlay(MKCircle(center: coordinate, radius: overlayRadius ?? 0))
    }
    
    // MARK: - Adds a Circle Overlay to the map.
    
    /**
     Must implement rendererFor in the used ViewController.
     
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
     if let circle = overlay as? MKCircle {
     let circleRenderer = MKCircleRenderer(circle: circle)
     circleRenderer.fillColor = .red
     circleRenderer.strokeColor = .blue
     circleRenderer.lineWidth = 1
     circleRenderer.alpha = 0.3
     return circleRenderer
     }
     return MKOverlayRenderer(overlay: overlay)
     }
     */
    func addCircleOverlay(coordinate: CLLocationCoordinate2D, radius: Double) {
        self.addOverlay(MKCircle(center: coordinate, radius: radius))
    }
    
    // MARK: - Adds a Polyline Overlay to the map.
    
    /**
     Must implement rendererFor in the used ViewController.
     
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
     */
    func addPolyline(points: [CLLocationCoordinate2D]) {
        self.addOverlay(MKPolyline(coordinates: points, count: 2))
    }
}

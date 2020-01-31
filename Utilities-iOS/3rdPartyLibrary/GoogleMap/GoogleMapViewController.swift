//  Created by SinaMN75 on 11/8/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import GoogleMaps
import MapKit

class GoogleMapViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView: GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView?.delegate = self
        
        GMSServices.provideAPIKey("AIzaSyCbPkQenJFmn99uOSdCW924Hz9_amFTn0A")
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        let lat = mapView.projection.coordinate(for: mapView.center).latitude
        let lng = mapView.projection.coordinate(for: mapView.center).longitude

        print("center Lat & Lng = \(lat), \(lng)")
      }
}

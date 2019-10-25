//  Created by SinaMN75 on 8/12/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import SwiftLocation
import CoreLocation

func currentLocation(locationResult: @escaping (Double, Double) -> Void) {
    LocationManager.shared.locateFromGPS(.continous, accuracy: .house) { result in
        switch result {
        case .failure( _):
            alertNormal(title: "خطا", message: "خطا در دریافت موقعیت", buttonTitle: "باشه") {}
        case .success(let location):
            locationResult(location.coordinate.latitude, location.coordinate.longitude)
        }
    }
}

func requestLocationPermission() {
    LocationManager.shared.requireUserAuthorization()
}

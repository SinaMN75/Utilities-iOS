//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import Foundation

let defaults = UserDefaults.standard

func set(value: Int, key: String) { defaults.set(value, forKey: key) }
func set(value: Double, key: String) { defaults.set(value, forKey: key) }
func set(value: Float, key: String) { defaults.set(value, forKey: key) }
func set(value: String, key: String) { defaults.set(value, forKey: key) }
func set(value: Bool, key: String) { defaults.set(value, forKey: key) }
func set(value: URL, key: String) { defaults.set(value, forKey: key) }
func set(value: Any, key: String) { defaults.set(value, forKey: key) }

func getInt(key: String) -> Int? { return defaults.integer(forKey: key) }
func getDouble(key: String) -> Double? { return defaults.double(forKey: key) }
func getFloat(key: String) -> Float? { return defaults.float(forKey: key) }
func getString(key: String) -> String? { return defaults.string(forKey: key) }
func getBool(key: String) -> Bool? { return defaults.bool(forKey: key) }
func getURL(key: String) -> URL? { return defaults.url(forKey: key) }
func getAny(key: String) -> Any? { return defaults.value(forKey: key) }


let appSupportDirectory: URL = {
    let url = FileManager().urls(for: .applicationSupportDirectory , in: .userDomainMask).first!
    if !FileManager().fileExists(atPath: url.path) {
        try? FileManager().createDirectory(at: url, withIntermediateDirectories: false)
    }
    return url
}()

//  Created by SinaMN75 on 8/12/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import Foundation
import Alamofire

typealias onResponse = ((_ response:DataResponse<Data>)->())
typealias onFailure = ((_ error:Error,_ response:DataResponse<Data> )->())

func send(url:String,
          method:HTTPMethod = .post,
          parameters:Parameters? = nil,
          encoding:JSONEncoding = JSONEncoding.default,
          header: HTTPHeaders,
          onResponse:@escaping onResponse,
          onFailure:onFailure?) {
    
    if (isConnectedToNetwork()) {
        Alamofire.request( url, method: method, parameters: parameters, encoding: encoding, headers: header).responseData{ response in
            switch response.result {
            case .success:
                do {
                    print("CLIENT -> routes: \(url)")
                    print("CLIENT -> params: \(parameters?.description ?? "PARAMS")")
                    print("SERVER -> status code : \(response.response?.statusCode ?? 999)")
                    onResponse(response)
                }
            case .failure(let error):
                do {
                    var errorMessage:String = String(data: (response.data)!, encoding: .utf8)!
                    if parameters != nil {
                        errorMessage += "\n *** PARAMETERS ***\n \(String(describing: parameters))"
                    }
                    print("CLIENT -> routes: \(url)")
                    print("CLIENT -> params: \(String(describing: parameters))")
                    print("SERVER -> status code : \(String(describing: response.response?.statusCode))")
                    print("CLIENT -> error message: \(errorMessage)")
                    if onFailure != nil {
                        onFailure!(error,response)
                    }
                    #if DEBUG
                    #else
                    #endif
                }
            }
        }
    } else { alert(title: "خطا", message: "ارتباط با اینترنت برقرار نیست", buttonTitle: "باشه") }
}

func upload(endUrl: String,
            imageData: Data?,
            withName: String,
            fileName: String,
            mimeType: String,
            headers: HTTPHeaders,
            parameters: [String : Any],
            onCompletion: ((JSON?) -> Void)? = nil,
            onError: ((Error?) -> Void)? = nil) {
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        for (key, value) in parameters { multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String) }
        if let data = imageData { multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: mimeType) }
        
    }, usingThreshold: UInt64.init(), to: endUrl, method: .post, headers: headers) { (result) in
        switch result{
        case .success(let upload, _, _):
            upload.responseJSON { response in
                print("Succesfully uploaded")
                if let err = response.error{
                    onError?(err)
                    return
                }
                onCompletion?(nil)
            }
        case .failure(let error):
            print("Error in upload: \(error.localizedDescription)")
            onError?(error)
        }
    }
}

func upload(image: UIImage,
            withName: String,
            fileName: String,
            mimeType: String,
            progressCompletion: @escaping (_ percent: Float) -> Void,
            completion: @escaping () -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
        print("Could not get JPEG representation of UIImage")
        return
    }
    
    Alamofire.upload(multipartFormData: { multipartFormData in
        multipartFormData.append(imageData, withName: withName, fileName: fileName, mimeType: mimeType)
    }, to: "http://api.imagga.com/v1/content", headers: ["Authorization": "Basic xxx"], encodingCompletion: { encodingResult in
    })
}

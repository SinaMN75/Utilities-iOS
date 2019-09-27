//  Created by SinaMN75 on 8/12/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import Foundation
import Alamofire

private func send(url:String,
                  method:HTTPMethod = .post,
                  parameters:Parameters? = nil,
                  encoding:JSONEncoding = JSONEncoding.default,
                  header: HTTPHeaders,
                  onResponse:@escaping ((_ response:DataResponse<Data>)->()),
                  onFailure:((_ error:Error,_ response:DataResponse<Data> )->())?) {
    
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
                        let errorMessage:String = String(data: (response.data)!, encoding: .utf8)!
                        if parameters != nil {
//                            errorMessage += "\n *** PARAMETERS ***\n" + JSON(parameters!).rawString()!
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
    } else {
        alertNormal(title: "خطا", message: "ارتباط با اینترنت برقرار نیست", buttonTitle: "باشه") {}
    }
}

//
//  ApiClient.swift
//  HomeScreen
//
//  Created by Ahmed on 8/3/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiClient : NSObject {
    
    func callHomeAPI(completion: @escaping (JSON?) -> Void) {
        Alamofire.request(EndPointURL.URL).responseJSON { response in
            switch response.result {
            case .success:
                var json = JSON(response.result.value!)

                completion(json)

                break
            case .failure(let error):
                print(error)
                completion(nil)
                break
            }
        }
        
    }
}

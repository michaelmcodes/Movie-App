//
//  ApiModel.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import Foundation
import Alamofire
import SwiftyJSON
class ApiHelper {
    static let sharedInstance = ApiHelper()
    static let emp = JSON()
    var saveData = JsonModel(data: emp)
    func getDetails(url: URL, params: [String:Any], completion:@escaping ()-> Void) {
        AF.request(url, parameters: params, encoding: URLEncoding.default).response {
            reponse in
            guard let data = reponse.data else { return }
            do {
                let json = try JSON(data: data)
                self.saveData = JsonModel(data: json)
                completion()
                print(json)
            }catch {
                print(error)
            }
        }
    }
}

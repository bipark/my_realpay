//
//  PayHelper.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/18.
//

import Foundation
import SwiftUI
import Alamofire

let baseUrl = "http://pnet.kr"

func CommaNumber(price:Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value:price))!
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

func sendPostPay(rdate:String, mypay:String) {
    
    
    if UserDefaults.standard.string(forKey: "userid") == nil {
        UserDefaults.standard.set(UUID().uuidString, forKey: "userid")
    }
    
    let params : Parameters = ["uuid":UserDefaults.standard.string(forKey: "userid")!,
                               "rdate":rdate,
                               "mypay":mypay]
    let headers:HTTPHeaders = [
        "Content-Type":"application/x-www-form-urlencoded",
        "Accept": "application/json"
    ]
    
    AF.request(baseUrl+"/api/paycalc/pay/add",
               method: .post,
               parameters: params,
               headers: headers).responseJSON { response in
                print(response.result)
               }
    
}

func getMyPayRank(mypay:Int, completionBlock: @escaping (String)->()) {
    
    let params : Parameters = ["mypay":mypay]
    let headers:HTTPHeaders = [
        "Content-Type":"application/x-www-form-urlencoded",
        "Accept": "application/json"
    ]
    
    AF.request(baseUrl+"/api/paycalc/rank",
               method: .get,
               parameters: params,
               headers: headers).responseJSON { response in
                switch response.result {
                case .success:
                    if let rank = (response.value as AnyObject)["result"] as? String {
                        completionBlock(rank)
                    }
                case .failure(let error):
                    completionBlock("0")
                    print(error)
                    return
                }
               }
    
}

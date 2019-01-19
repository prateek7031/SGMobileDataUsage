//
//  API.swift
//  Mobile Data Usage
//
//  Created by Prateek on 18/01/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit
import Network
import SystemConfiguration

//import Alamofire
let baseUrl =  "https://data.gov.sg/api"
let resourceId =  "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"

class API: NSObject {
    typealias responseDict = (_ result: [String:Any]?, _ error: NSError?) -> Void
    typealias responseYearRecord = (_ result: [YearRecord]?, _ error: NSError?) -> Void

    class func showAlert (message:String, withTitle:String, vc:UIViewController) {
        let alertController = UIAlertController(title: withTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: NSLocalizedString("title_ok", comment: ""), style: UIAlertAction.Style.default)
        {
            (result : UIAlertAction) -> Void in
            //print("You pressed OK")
        }
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }

    
    
    class func searchMobileData(responseRec:@escaping responseYearRecord){
        let strAPIURL = baseUrl + "/action/datastore_search" + "?resource_id=" + resourceId
        callGetAPI(urlString: strAPIURL) { (response, error) in
            print("response \(String(describing: response))")
            
            if let responseData = response{
                let responseObj = Response(fromDictionary: responseData)
                var finalArrRecord : [YearRecord] = []
                if(responseObj.success == true){
                    if let arrRecord = responseObj.result["records"] as? [[String:Any]] {
                        var arrRecords = [Record]()
                        for dictRecord in arrRecord {
                            let record = Record(fromDictionary: dictRecord)
                            if let previousRecord = arrRecords.last{
                                let relativeData =  record.volumeOfMobileData - previousRecord.volumeOfMobileData
                                record.relativeData = relativeData
                            }
                            arrRecords.append(record)
                            let yearRecords = finalArrRecord.filter({ (yearRecord) -> Bool in
                                if (yearRecord.year == record.year){
                                    yearRecord.addRecord(fromRecord: record)
                                    return true
                                }else{
                                    return false
                                }
                                
                            })
                            if(yearRecords.count == 0 ){
                                let yearRecord = YearRecord(fromRecord: record)
                                finalArrRecord.append(yearRecord)
                            }
                            
                        }
                        
                    }
                    print("final data \(finalArrRecord)")
                    responseRec(finalArrRecord,nil)
                }
            }else{
                responseRec(nil,error)

            }

            
        }
    }
    
    class func callGetAPI(urlString:String,consumer:@escaping responseDict)  {
        //https://data.gov.sg/dataset/22d7cb93-b85d-4e93-ab90-a10cfabca507/resource/a807b7ab-6cad-4aa6-87d0-e283a7353a0f/data?limit=2000
        let request = NSMutableURLRequest()
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.timeoutInterval = 120
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.url = NSURL.init(string: urlString ) as URL?
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            // check for any errors
            
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
//                let errorDict = ["errorMessage":""]
                let userInfo: [String : Any] =
                    [NSLocalizedDescriptionKey :  "Please try again!" ,NSLocalizedFailureReasonErrorKey : "API Error"]
                let error = NSError(domain: "Data not found", code: 301, userInfo: userInfo)
                 consumer(nil, error)
                
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                
                let userInfo: [String : Any] =
                    [NSLocalizedDescriptionKey :  "Response Not found" ,NSLocalizedFailureReasonErrorKey : "ReponseNotFound"]
                let error = NSError(domain: "Data not found", code: 302, userInfo: userInfo)
                consumer(nil , error)
                
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                
                guard let repsoneDict:[String:AnyObject] = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:AnyObject] else {
                    print("error trying to convert data to JSON")
                    

                    let userInfo: [String : Any] =
                        [NSLocalizedDescriptionKey :  "Response is not valid" ,NSLocalizedFailureReasonErrorKey : "ReponseDataNotValid"]
                    let error = NSError(domain: "Data not found", code: 303, userInfo: userInfo)
                    
                                        consumer(nil , error)
                    return
                }
                
                // let  todo1  = NSMutableDictionary.init(dictionary: todo);
                
                //                //print("App \(todo1)")
                //print("Get Request Response : \(todo)")
                
               
                consumer(repsoneDict, nil)
                
            } catch  {
                
                let res: String = String(data: responseData, encoding: String.Encoding.utf8)!
                print(" Error Res Str \(res)")
                //print("error trying to convert data to JSON")
                
                
            }
        }
        task.resume()
    }
    
    class func isNetworkConnected() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}



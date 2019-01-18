//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Response : NSObject, NSCoding{

	var help : String!
    var result : [String:Any]!
	var success : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		help = dictionary["help"] as? String
		if let resultData = dictionary["result"] as? [String:Any]{
			result = resultData
		}
		success = dictionary["success"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if help != nil{
			dictionary["help"] = help
		}
		if result != nil{
			dictionary["result"] = result
		}
		if success != nil{
			dictionary["success"] = success
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         help = aDecoder.decodeObject(forKey: "help") as? String
        result = aDecoder.decodeObject(forKey: "result") as?  [String:Any]
         success = aDecoder.decodeObject(forKey: "success") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if help != nil{
			aCoder.encode(help, forKey: "help")
		}
		if result != nil{
			aCoder.encode(result, forKey: "result")
		}
		if success != nil{
			aCoder.encode(success, forKey: "success")
		}

	}

}

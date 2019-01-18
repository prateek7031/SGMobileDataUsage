//
//	Record.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Record : NSObject, NSCoding{

	var id : Int!
    var year : String!
	var quarter : String!
	var volumeOfMobileData : Double!
    var relativeData : Double!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["_id"] as? Int
		let quarterCombined = dictionary["quarter"] as? String
	let	strVolumeOfMobileData = dictionary["volume_of_mobile_data"] as? String
        if let arrSplit = quarterCombined?.components(separatedBy: "-"){
            year    = arrSplit[0]
            quarter = arrSplit[1]
            volumeOfMobileData = strVolumeOfMobileData?.toDouble()
        }

	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["_id"] = id
		}
		if quarter != nil{
			dictionary["quarter"] = quarter
		}
		if volumeOfMobileData != nil{
			dictionary["volume_of_mobile_data"] = volumeOfMobileData
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? Int
         quarter = aDecoder.decodeObject(forKey: "quarter") as? String
//         volumeOfMobileData = aDecoder.decodeObject(forKey: "volume_of_mobile_data") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if quarter != nil{
			aCoder.encode(quarter, forKey: "quarter")
		}
		if volumeOfMobileData != nil{
			aCoder.encode(volumeOfMobileData, forKey: "volume_of_mobile_data")
		}

	}

}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

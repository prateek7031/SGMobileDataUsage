//
//  YearRecord.swift
//  Mobile Data Usage
//
//  Created by Prateek on 18/01/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit

class YearRecord: NSObject {
    var year : String!
    var q4Value : Double!
    var relativeForYear : Double! = 0.0
    var lossQuarter : String!
    var records : [Record] = []
    
    
    var q1Total : String!
    var q1Relative : String!

    var q2Total : String!
    var q2Relative : String!

    var q3Total : String!
    var q3Relative : String!

    var q4Total : String!
    var q4Relative : String!

    init(fromRecord record: Record){
        super.init()
      year = record.year
        updateData(record: record)
      records.append(record)
        
    }
    
    func addRecord(fromRecord record: Record){
        self.updateData(record: record)
        records.append(record)
    }
    func updateData(record: Record){
        if record.relativeData != nil {
            relativeForYear = relativeForYear + record.relativeData
        }
        if record.relativeData != nil && record.relativeData<0{
            if lossQuarter == nil {
                lossQuarter = record.quarter
            }else {
                lossQuarter = lossQuarter + ", " + record.quarter
            }
        }
        if record.relativeData == nil {
            record.relativeData = 0.0
        }
        
        switch record.quarter {
        case "Q1":
            q1Total = String(format: "%.4f",record.volumeOfMobileData)
            q1Relative = String(format: "%.4f",record.relativeData)
        case "Q2":
            q2Total = String(format: "%.4f",record.volumeOfMobileData)
            q2Relative = String(format: "%.4f",record.relativeData)
        case "Q3":
            q3Total = String(format: "%.4f",record.volumeOfMobileData)
            q3Relative = String(format: "%.4f",record.relativeData)
        case "Q4":
            q4Total = String(format: "%.4f",record.volumeOfMobileData)
            q4Relative = String(format: "%.4f",record.relativeData)
            q4Value = record.volumeOfMobileData

        default:
            break
        }
        
//        if(record.quarter == "Q4" ){
//        }/
    }
    

}

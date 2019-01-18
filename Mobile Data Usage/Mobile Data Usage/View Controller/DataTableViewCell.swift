//
//  DataTableViewCell.swift
//  Mobile Data Usage
//
//  Created by Prateek on 17/01/19.
//  Copyright © 2019 Personal. All rights reserved.
//
//import FoldingCell
import UIKit

class DataTableViewCell: FoldingCell {
    var number: Int = 0
    @IBOutlet weak var lblYearForgrounView: UILabel!
    @IBOutlet weak var lblLossQuarter: UILabel!
    @IBOutlet weak var lblQ4Value: UILabel!
    @IBOutlet weak var lblRelativeOfyear: UILabel!
    
    //
    
    @IBOutlet weak var lblYearContainerView: UILabel!
    @IBOutlet weak var lblTotalValume: UILabel!
    @IBOutlet weak var lblRelativeValume: UILabel!

    @IBOutlet weak var lblQ1Total: UILabel!
    @IBOutlet weak var lblQ1Relative: UILabel!
    
    @IBOutlet weak var lblQ2Total: UILabel!
    @IBOutlet weak var lblQ2Relative: UILabel!
    
    @IBOutlet weak var lblQ3Total: UILabel!
    @IBOutlet weak var lblQ3Relative: UILabel!
    
    @IBOutlet weak var lblQ4Total: UILabel!
    @IBOutlet weak var lblQ4Relative: UILabel!


    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupData(yearRecord:YearRecord){
        self.lblYearForgrounView.text  = yearRecord.year!
        self.lblYearContainerView.text  = yearRecord.year!

        if yearRecord.lossQuarter != nil {
            self.lblLossQuarter.text = "\(String(describing: yearRecord.lossQuarter!)) ↓"
        }else{
             self.lblLossQuarter.text  = ""
        }
        
        if yearRecord.q4Value != nil {
            
            self.lblQ4Value.text = "Total \(yearRecord.year!) →  \(String(format: "%.4f",yearRecord.q4Value))"
             self.lblTotalValume.text =  String(format: "%.4f",yearRecord.q4Value)

        }else{
            self.lblQ4Value.text = "Total \(yearRecord.year!) → TBA"

        }
        
        self.lblRelativeOfyear.text = String(format: "%.4f",yearRecord.relativeForYear)
        self.lblRelativeValume.text =  String(format: "%.4f",yearRecord.relativeForYear)
        
        if yearRecord.q1Total != nil {
            self.lblQ1Total.text = yearRecord.q1Total
        }else{
            self.lblQ1Total.text = "-"
        }
        
        if yearRecord.q1Relative != nil {
            self.lblQ1Relative.text = yearRecord.q1Relative
        }else{
            self.lblQ1Relative.text = "-"
        }
        
        if yearRecord.q2Total != nil {
            self.lblQ2Total.text = yearRecord.q2Total

        }else{
            self.lblQ2Total.text = "-"
        }
        
        if yearRecord.q2Relative != nil {
            self.lblQ2Relative.text = yearRecord.q2Relative
        }else{
            self.lblQ2Relative.text = "-"
        }

        
        if yearRecord.q3Total != nil {
            self.lblQ3Total.text = yearRecord.q3Total

        }else{
            self.lblQ3Total.text = "-"
        }
        
        if yearRecord.q3Relative != nil {
            self.lblQ3Relative.text = yearRecord.q3Relative
        }else{
            self.lblQ3Relative.text = "-"
        }

        
        if yearRecord.q4Total != nil {
            self.lblQ4Total.text = yearRecord.q4Total

        }else{
            self.lblQ4Total.text = "-"
        }
        
        if yearRecord.q4Relative != nil {
            self.lblQ4Relative.text = yearRecord.q4Relative
        }else{
             self.lblQ4Relative.text = "-"
        }

        

        
       
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

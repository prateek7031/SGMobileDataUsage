//
//  DataListViewController.swift
//  Mobile Data Usage
//
//  Created by Prateek on 17/01/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit

class DataListViewController: UIViewController {
    
    enum Const {
        static let closeCellHeight: CGFloat = 80
        static let openCellHeight: CGFloat = 310
        
        static let rowsCount = 10
    }
    
    var cellHeights: [CGFloat] = []
    var finalRecords = [YearRecord]()

    @IBOutlet weak var tblDataList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if API.isNetworkConnected(){
            getMobileData()
        }else {
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "Network connection Failed", message: "Please try again later!", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //API called to get the data
    func getMobileData(){
        API.searchMobileData { (arrRecords, error) in
            if(arrRecords != nil){
                self.finalRecords =  (arrRecords?.filter({ (yearRecord) -> Bool in
                    if(Int(yearRecord.year)! > 2007){
                        return  true
                    } else{
                        return false
                    }
                }))!
                DispatchQueue.main.async {
                    self.setup()
                    self.tblDataList.reloadData()
                }
            }
            
            self.finalRecords.reverse()
        }
    }
    
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: finalRecords.count)
        tblDataList.estimatedRowHeight = Const.closeCellHeight
        tblDataList.rowHeight = UITableView.automaticDimension
        //tblDataList.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            tblDataList.refreshControl = UIRefreshControl()
            tblDataList.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tblDataList.refreshControl?.endRefreshing()
            }
            self?.tblDataList.reloadData()
        })
    }

}
extension DataListViewController : UITableViewDataSource, UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        cell.setupData(yearRecord: finalRecords[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.finalRecords.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DataTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row

    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
}

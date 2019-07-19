//
//  AttendanceDetailsVC.swift
//  JsonPractice
//
//  Created by Murali on 7/18/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

class AttendanceDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableList: UITableView!
    var titleArr = ["Total Days","Working Days","Leaves","Absents","Days Attended","Updates Sent","Working Days","Worked Hrs","Spent Summary","Worked Per Day","Shortage Per Day","Late to Office","Min. Hrs Missed","Max Points","Points Earned","Performance Score"]
    var URLReq:URLRequest!
    var dataTask:URLSessionDataTask!


    override func viewDidLoad() {
        super.viewDidLoad()
        print("$$$$$$$$$$\(attendanceArr)$$$$$$$$$$$")
       callData()
       
    }
 
    override func viewWillAppear(_ animated: Bool) {
        tableList.reloadData()
    }
    func callData(){
        self.URLReq = URLRequest(url: URL(string:"https://www.brninfotech.com/pulse/modules/admin/DashboardSnippets.php")!)
        self.URLReq.httpMethod = "POST"
        
        let dataSend = "funcName=getUserAttendance&studentIDByAdmin=NoValue"
        
        self.URLReq.httpBody = dataSend.data(using: String.Encoding.utf8)
        
        self.dataTask = URLSession.shared.dataTask(with: self.URLReq, completionHandler: { (data, response, err) in
            print(data!)
            print("got response from server")
            
            do
            {
                let convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:Any]]
                
                print(convertedData[0])
                DispatchQueue.main.async {
                    attendanceArr = [convertedData[0]["totalDays"]!,convertedData[0]["totalWorkingDays"]!,convertedData[0]["totalLeaves"]!,convertedData[0]["totalAbsents"]!,convertedData[0]["totalDaysAttended"]!,convertedData[0]["totalUpdatesSent"]!,convertedData[0]["totalWorkingHours"]!,convertedData[0]["totalWorkedHours"]!,convertedData[0]["totalShortageHours"]!,convertedData[0]["avgWorkingHours"]!,convertedData[0]["avgShortageHours"]!,convertedData[0]["numberOfTimesLateToOffice"]!,convertedData[0]["numberOfTimesMinimumHoursMissed"]!,convertedData[0]["maxPoints"]!,convertedData[0]["pointsScored"]!,convertedData[0]["percScored"]!]
                    print(attendanceArr)
                self.tableList.reloadData()
                    
                }
                
            }
            catch
            {
                print("Unable to load")
            }
        })
        self.dataTask.resume()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceArr.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableList.dequeueReusableCell(withIdentifier: "AttendanceTVCell", for: indexPath) as! AttendanceTVCell
        cell.listLbl.text = titleArr[indexPath.row]
        cell.detailLbl.text = "\(attendanceArr[indexPath.row])"
        return cell

    }

}

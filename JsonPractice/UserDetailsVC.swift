//
//  UserDetailsVC.swift
//  JsonPractice
//
//  Created by Murali on 7/17/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

var attendanceArr:[Any] = []
class UserDetailsVC: UIViewController {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var userBatchID: UILabel!
    @IBOutlet var userStudentID: UILabel!
    @IBOutlet var userEmailID: UILabel!
   
    var tableRef:AttendanceDetailsVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    
    
    @IBAction func onBtnTap(_ sender: Any) {
        var attendavceVC = storyboard?.instantiateViewController(withIdentifier: "AttendanceDetailsVC") as! AttendanceDetailsVC
        self.present(attendavceVC, animated: true) {
    
        }
       
        }
        


}

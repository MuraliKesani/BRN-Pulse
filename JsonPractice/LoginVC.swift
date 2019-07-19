//
//  LoginVC.swift
//  JsonPractice
//
//  Created by Murali on 7/17/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

var UserDetailsArr:[Any] = []

class LoginVC: UIViewController {

    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    var urlREQ:URLRequest!
    var sessionDataTask:URLSessionDataTask!
    
    var detailsArray:[String] = []
    
    var userVC:UserDetailsVC!
    override func viewDidLoad() {
        super.viewDidLoad()

//                        emailTF.text = "kesani.murali@gmail.com"
//                        passwordTF.text = "munna341820"
        
        emailTF.text = "gnaneswar.9@gmail.com"
        passwordTF.text = "8099904569"
    }
    

    @IBAction func onLoginBtnTap(_ sender: Any) {
        let urlString = URL(string: "https://www.brninfotech.com/pulse/modules/admin/ValidateLogin.php")
        
        
        urlREQ = URLRequest(url: urlString!)
        urlREQ.httpMethod = "POST"
        
        let dataToSend = "registeredEmail=\(self.emailTF.text!)&registeredPassword=\(self.passwordTF.text!)&funcName=verifyLogin"
        
        urlREQ.httpBody = dataToSend.data(using: String.Encoding.utf8)
        sessionDataTask = URLSession.shared.dataTask(with: urlREQ) { (data, response, error) in
            
            print(self.sessionDataTask!)
            print("Got Response")
            do{
                var converting2JSON  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:String]
                print("*********\(converting2JSON)***********")
                
                DispatchQueue.main.async {
                    if(converting2JSON["loggedIn"] == "no"){
                        
                        let alert = UIAlertController(title: "WARNING", message: "INVALID USERNAME/PASSWORD", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                       UserDetailsArr = [converting2JSON["firstName"]!,converting2JSON["surName"]!,converting2JSON["batchID"]!,converting2JSON["studentID"]!,converting2JSON["registeredEmail"]!,converting2JSON["profileImagePath"]!]
                        self.userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsVC") as!  UserDetailsVC
                        self.present(self.userVC, animated: true, completion: {
                            print("HEloooooooo")
                            self.userVC.userNameLbl.text! = ("\(UserDetailsArr[0]) \(UserDetailsArr[1])")
                            
                            
                            self.userVC.userBatchID.text! = UserDetailsArr[3] as! String
                            self.userVC.userStudentID.text! = UserDetailsArr[2] as! String
                            self.userVC.userEmailID.text! = UserDetailsArr[4] as! String
                            
                            
                            var imgStr = UserDetailsArr[5] as! String
                            
                            imgStr = imgStr.replacingOccurrences(of: "../uploads/", with: "")
                            
                            let url = NSURL(string: "https://www.brninfotech.com/pulse/modules/uploads/\(imgStr)")
                            let data = NSData(contentsOf: url! as URL)
                            if(data != nil){
                                self.userVC.userImage.image = UIImage(data: data! as Data)
                            }
                            
//                            imgStr = imgStr.replacingOccurrences(of: "../uploads/", with: "")
//
//                            let originalUrl = "http://www.brninfotech.com/pulse/modules/uploads/\(imgStr)"
//                            let urlString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//                            let URL = NSURL(string: urlString!)
//                            let data = NSData(contentsOf: URL! as URL)
//                            if data != nil
//                            {
//                                self.userVC.userImage.image = UIImage(data: data! as Data)
//                            }
                        })
                        
                    }
                }
                
            }catch{
                print("something wrong")
            }
        }
        sessionDataTask.resume()
    }
    

}

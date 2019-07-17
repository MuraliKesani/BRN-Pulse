//
//  ViewController.swift
//  JsonPractice
//
//  Created by Murali on 7/17/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var urlREQ:URLRequest!
    var sessionDataTask:URLSessionDataTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onBtnTap(_ sender: Any) {
       
        let urlString = URL(string: "https://www.brninfotech.com/pulse/modules/admin/ValidateLogin.php")
        
        
        urlREQ = URLRequest(url: urlString!)
        urlREQ.httpMethod = "POST"
        
        let dataToSend = "registeredEmail=kesani.murali@gmail.com&registeredPassword=munna341820&funcName=verifyLogin"
        urlREQ.httpBody = dataToSend.data(using: String.Encoding.utf8)
        sessionDataTask = URLSession.shared.dataTask(with: urlREQ) { (data, response, error) in
            
            print(self.sessionDataTask!)
            print("Got Response")
            do{
                var converting2JSON  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print("*********\(converting2JSON)***********")
                
            }catch{
                print("something wrong")
            }
        }
        sessionDataTask.resume()
        
        
    }
    

}


//
//  ViewController_LogIn.swift
//  PHP_Test3
//
//  Created by Salim on 5/5/20.
//  Copyright © 2020 Salim3dd. All rights reserved.
//

import UIKit

var LogInUserName = "";
class ViewController_LogIn: UIViewController {

   @IBOutlet weak var TextUserName: UITextField!
   @IBOutlet weak var TextPassWord: UITextField!
   override func viewDidLoad() {
       super.viewDidLoad()

       
   }
   
   @IBAction func BTN_LogInClick(_ sender: Any) {
       
            if (TextUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" ) {
               
                       self.TextUserName.becomeFirstResponder()
                   }else{
                         if (TextPassWord.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""){
                             
                               self.TextPassWord.becomeFirstResponder()
                           }else{
                               LogIn()
                           }
                   }
       
   }
   
   func LogIn(){
      
       self.view.endEditing(true);
     
       let UserName = (TextUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
       let PassWord = (TextPassWord.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
                                  
      
       //رابط ملف php
       let Rurl =  "https://novbook.net/test/LogIn.php"
       let requestURL = NSURL(string: Rurl)
       let request = NSMutableURLRequest(url: requestURL! as URL)
       request.httpMethod = "POST"
       
       let postParametersC = "UserName="+UserName+"&PassWord="+PassWord;
       
       request.httpBody = postParametersC.data(using: String.Encoding.utf8)
       let task = URLSession.shared.dataTask(with: request as URLRequest){
           data, response, error in
           
           if error != nil{
               return
           }
           do {
               
               let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
               if let parseJSON = myJSON {
                   
                   var success : String!
                   success = parseJSON["success"] as! String?
                   
                   DispatchQueue.main.sync {
                       
                       if success.contains("LogIn_Error"){
                        self.AlertMessage(msg: "خطأ في إدخال البيانات", logOK: false)
                       }
                                              
                       if success.contains("LogIn_OK"){
                        LogInUserName = UserName
                        self.AlertMessage(msg: "تم الدخول بشكل صحيح", logOK: true)
                        
                       }
                      
                   }
               }
           } catch {
               print(error)
           }
       }
       task.resume()
   }

   //رسالة تأكيد الادخال
    func AlertMessage(msg: String, logOK: Bool){
       let alert = UIAlertController(title: "LogIn", message: msg, preferredStyle: UIAlertController.Style.alert)
                                     
       alert.addAction(UIAlertAction(title: "إغلاق", style: UIAlertAction.Style.cancel, handler: { action in
         if(logOK){
            self.performSegue(withIdentifier: "Show_LogInPage", sender: "")
         }
        self.dismiss(animated: true, completion: nil)
       }))
                                     
        self.present(alert, animated: true, completion: nil)
   }


}

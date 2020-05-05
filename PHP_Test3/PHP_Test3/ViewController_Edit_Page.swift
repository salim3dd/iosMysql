//
//  ViewController_Edit_Page.swift
//  PHP_Test3
//
//  Created by Salim on 4/13/20.
//  Copyright © 2020 Salim3dd. All rights reserved.
//

import UIKit

class ViewController_Edit_Page: UIViewController {
    @IBOutlet weak var TextUserName: UITextField!
    @IBOutlet weak var TextEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        TextUserName.text = EditUseName
        TextEmail.text = EditEmail
                
    }
    
    @IBAction func BTN_EditDataClick(_ sender: Any) {
        
             if (TextUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" ) {
                
                //self.showToast(message: "يجب كتابة اسم المستخدم")
                        self.TextUserName.becomeFirstResponder()
                    }else{
                          if (TextEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""){
                               // self.showToast(message: "يجب كتابة البريد الالكتروني بشكل صحيح")
                                self.TextEmail.becomeFirstResponder()
                            }else{
                                EditData()
                            }
                    }
        
    }
    
    func EditData(){
       
        self.view.endEditing(true);
      
        let UserName = (TextUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let Email = (TextEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
                     
               
       
        //رابط ملف php
        let Rurl =  "https://novbook.net/test/EditPage.php"
        let requestURL = NSURL(string: Rurl)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        
        let postParametersC = "UserName="+UserName+"&Email="+Email+"&id="+EditUser_id;
        
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
                        
                        if success.contains("Error"){
                            self.AlertMessage(msg: "خطأ في إدخال البيانات")
                        }
                                               
                        if success.contains("Update_OK"){
                            self.AlertMessage(msg: "تم تعديل البيانات بشكل صحيح")
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
    func AlertMessage(msg: String){
        let alert = UIAlertController(title: "insert", message: msg, preferredStyle: UIAlertController.Style.alert)
                                      
        alert.addAction(UIAlertAction(title: "إغلاق", style: UIAlertAction.Style.cancel, handler: { action in
            self.performSegue(withIdentifier: "Show_FirstPage", sender: "")
        }))
                                      
         self.present(alert, animated: true, completion: nil)
    }
    

}

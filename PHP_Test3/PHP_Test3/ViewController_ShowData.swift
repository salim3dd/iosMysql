//
//  ViewController_ShowData.swift
//  PHP_Test3
//
//  Created by Salim on 4/13/20.
//  Copyright © 2020 Salim3dd. All rights reserved.
//

import UIKit

var EditUseName=""
var EditUser_id=""
var EditEmail=""

class ViewController_ShowData: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var myTableView: UITableView!
    var tableViewItems = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.estimatedRowHeight = 100
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.separatorColor = UIColor.clear
        myTableView.register(UINib(nibName: "Users_List_nib", bundle: nil),
        forCellReuseIdentifier: "Id_TableView_myCell")
        
        LoadData()
    }
     
    func LoadData(){
           self.tableViewItems.removeAll()
         
           let UrlLink = "https://novbook.net/test/ShowData.php"
           let url = URL(string: UrlLink)
           
           let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
               
               if error != nil {
                   print("Error")
                   return
               }
               do {
                   
                   let myJson = try JSONSerialization.jsonObject(with: data!, options:
                       JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                   
                  
                   if let AllUsers = myJson["All_Users"] as? [[String : AnyObject]] {
                       
                       for User in AllUsers {
                           let List_ShowData = ListShowData()
                           if  let eid = User["id"] as? String,
                               let eUserName = User["UserName"] as? String,
                               let eEmail = User["Email"] as? String,
                               let eRegDate = User["RegDate"] as? String,
                               let eAvatar = User["Avatar"] as? String {
                            
                            List_ShowData.id = eid
                            List_ShowData.Username = eUserName
                            List_ShowData.Email = eEmail
                            List_ShowData.RegDate = eRegDate
                            List_ShowData.Avatar = eAvatar
                               
                           }
                           self.tableViewItems.append(List_ShowData)
                       }
                       
                   }
                   DispatchQueue.main.sync {
                       self.myTableView.reloadData()
                       
                   }
                   
               }catch {
                   //Error
               }
               
           }
           
           task.resume()
           
       }
    
    //TableView
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
       func numberOfSections(in tableView: UITableView) -> Int {
           return tableViewItems.count
       }
            
    
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableViewItems.count > 0){
           if let ReadingItem = tableViewItems[indexPath.section] as? ListShowData {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Id_TableView_myCell", for: indexPath) as! TableViewCell_mycell
                
            cell.la_UserName.text = "UserName: "+ReadingItem.Username!
            cell.la_Email.text = "Email: "+ReadingItem.Email!
            cell.la_RegDat.text = "RegDate: "+ReadingItem.RegDate!
            
            let AvatarLink = "https://novbook.net/test/Images/"+ReadingItem.Avatar!
            
            if let Imgurl = URL(string: AvatarLink){
                do{
                    let Imgdata = try Data(contentsOf: Imgurl)
                    cell.ImgAvatar.image = UIImage(data: Imgdata)
                }catch let err{
                    print("Error: \(err.localizedDescription)")
                }
            }
            
            
//زر التعديل
            let BTN_Edit_tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BTN_EditUserData(tapGestureRecognizer:)))
            cell.BTN_Edit.tag = indexPath.section
            cell.BTN_Edit.addGestureRecognizer(BTN_Edit_tapGestureRecognizer)
            
            
            //زر الحذف
            let BTN_Delete_tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BTN_DeleteUser(tapGestureRecognizer:)))
            cell.BTN_Delete.tag = indexPath.section//Int(ReadingItem.id!)!
            cell.BTN_Delete.addGestureRecognizer(BTN_Delete_tapGestureRecognizer)
            
            
                return cell
            }
        }
        return UITableViewCell()
        
    }
          
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
       
         
     }
    
    @objc func BTN_EditUserData(tapGestureRecognizer: UITapGestureRecognizer){
           let viewF = tapGestureRecognizer.view!
           let ReadingItem = tableViewItems[viewF.tag] as? ListShowData
            EditUseName=ReadingItem!.Username!
            EditUser_id=ReadingItem!.id!
            EditEmail=ReadingItem!.Email!
        
         performSegue(withIdentifier: "Show_EditPage", sender: "")
       }
    
    
    @objc func BTN_DeleteUser(tapGestureRecognizer: UITapGestureRecognizer){
        let viewF = tapGestureRecognizer.view!
        let ReadingItem = tableViewItems[viewF.tag] as? ListShowData
                   
        let alert = UIAlertController(title: "حذف بيانات", message: " سيتم حذف بيانات"+ReadingItem!.Username!+"  لا يمكن التراجع هل أنت متأكد؟", preferredStyle: UIAlertController.Style.alert)
               
               alert.addAction(UIAlertAction(title: "حذف نهائي", style: UIAlertAction.Style.destructive, handler: { action in
                   
                    self.SendDataToDelete(id: ReadingItem!.id!)
                   self.dismiss(animated: true, completion: nil)
                   
               }))
               
               alert.addAction(UIAlertAction(title: "إغلاق", style: UIAlertAction.Style.cancel, handler: { action in
                   self.dismiss(animated: true, completion: nil)
                   
               }))
               
               self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func SendDataToDelete(id: String){
                  
       
        //رابط ملف php
        let Rurl =  "https://novbook.net/test/Delete_User.php"
        let requestURL = NSURL(string: Rurl)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        
        let postParametersC = "id="+id;
        
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
                            self.AlertMessage(msg: "خطأ")
                        }
                                               
                        if success.contains("Delete_OK"){
                            self.AlertMessage(msg: "تم حذف البيانات")
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
        let alert = UIAlertController(title: "DELETE", message: msg, preferredStyle: UIAlertController.Style.alert)
                                      
        alert.addAction(UIAlertAction(title: "إغلاق", style: UIAlertAction.Style.cancel, handler: { action in
            self.LoadData()
        
        }))
         self.present(alert, animated: true, completion: nil)
    }
}

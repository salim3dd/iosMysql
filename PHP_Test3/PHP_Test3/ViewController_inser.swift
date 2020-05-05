//
//  ViewController_inser.swift
//  PHP_Test3
//
//  Created by Salim on 4/13/20.
//  Copyright © 2020 Salim3dd. All rights reserved.
//

import UIKit

class ViewController_inser: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var TextUserName: UITextField!
    @IBOutlet weak var TextEmail: UITextField!
    @IBOutlet weak var TextPassWord: UITextField!
    @IBOutlet weak var ImgAvatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //عرض الصورة بشكل دائرة
        ImgAvatar.layer.borderWidth = 2
        ImgAvatar.layer.masksToBounds = false
        ImgAvatar.layer.borderColor = UIColor.white.cgColor
        ImgAvatar.layer.cornerRadius = ImgAvatar.frame.height/2
        ImgAvatar.clipsToBounds = true
        
        //عند الضغط على الصورة
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
               ImgAvatar.isUserInteractionEnabled = true
               ImgAvatar.addGestureRecognizer(tapGestureRecognizer)
               
        
    }
    
    //كود تحويل الصورة الى كود نص
    func decodeBase64(strEncodeData: String) -> UIImage {
           
           let dataDecoded  = NSData(base64Encoded: strEncodeData, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
           let image = UIImage(data: dataDecoded as Data)
           return image!
           
       }
       //اختيار الصورة من المعرض
       @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
       {
           //let tappedImage = tapGestureRecognizer.view as! UIImageView
           let image = UIImagePickerController()
           image.delegate = self
           image.sourceType = UIImagePickerController.SourceType.photoLibrary
           image.allowsEditing = true
           self.present(image, animated:  true)
           {
               
           }
       }
       
    //بعد اختيار الصورة من المعرض يتصل بهذا الميثود
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
               if let img1 = pickedImage.jpegData(compressionQuality: 0.90){
                   let imgz = resizeImage(image: UIImage(data: img1)!)
                   ImgAvatar.image = maskRoundedImage(image: imgz!, radius:75)//
                  
               }
           }
           dismiss(animated: true, completion: nil)
       }
       
    //في حالة كنسل الامر يتم غلق الرسالة
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
    
    
    //كود إعادة تحجيم الصورة وعرضها بالابعاد الجديدة - غالبا المستخدم يختار صورة اذا كانت بحجم كبير جدا سيتأخر التطبيق في رفع الصورة إلى السيرفر وايضا سيكون حجم الصورة كبير جدا وسيصعب عرضها في التطبيق وذلك يجب قبل الارسال تصغير الصورة بالقياس المعقول للرفع والعرض
       func resizeImage(image: UIImage) -> UIImage? {
           UIGraphicsBeginImageContext(CGSize(width: 550, height: 550))
           image.draw(in: CGRect(x: 0, y: 0, width:550, height: 550))
           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return newImage
       }
    
    
    // كود إعادة قص الصورة بشكل دائرة اذا رغبت في ذلك
       func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
           let imageView: UIImageView = UIImageView(image: image)
           var layer: CALayer = CALayer()
           layer = imageView.layer
           layer.masksToBounds = true
           layer.cornerRadius = radius
           UIGraphicsBeginImageContext(imageView.bounds.size)
           layer.render(in: UIGraphicsGetCurrentContext()!)
           let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return roundedImage!
       }
    
    
    
    
    //نهاية كود الصور
    
    
    
    
    
    @IBAction func BTN_SendDataClick(_ sender: Any) {
        
             if (TextUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" ) {
                
                //self.showToast(message: "يجب كتابة اسم المستخدم")
                        self.TextUserName.becomeFirstResponder()
                    }else{
                        if (TextPassWord.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "") {
                           // self.showToast(message: "يجب كتابة كلمة المرور")
                            self.TextPassWord.becomeFirstResponder()
                        }else{
                            if (TextEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""){
                               // self.showToast(message: "يجب كتابة البريد الالكتروني بشكل صحيح")
                                self.TextEmail.becomeFirstResponder()
                            }else{
                                Registration()                                
                            }
                        }
                    }
        
    }
    
    func Registration(){
       
        self.view.endEditing(true);
      
        let UserName = (TextUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let Email = (TextEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let PassWord = (TextPassWord.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
             
 
        //*****كود الصورة
        //يتم تحويل الصورة إلى نص برمجي ويرسل كنص إلى ملفphp
        var ImagCode_Avatar = ""
               
               let img = ImgAvatar.image
               let imageData:Data =  img!.jpegData(compressionQuality: 0.5)!
               ImagCode_Avatar = imageData.base64EncodedString()
              
       //*****
        
        
        
        
        //رابط ملف php
        let Rurl =  "https://novbook.net/test/insert.php"
        let requestURL = NSURL(string: Rurl)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let postParametersC = "UserName="+UserName+"&Email="+Email+"&PassWord="+PassWord+"&ImagCode_Avatar="+ImagCode_Avatar;
        
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
                                               
                        if success.contains("Reg_OK"){
                            self.AlertMessage(msg: "تم إدخال البيانات بشكل صحيح")
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
          self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)                                           }))
                                      
         self.present(alert, animated: true, completion: nil)
    }
}

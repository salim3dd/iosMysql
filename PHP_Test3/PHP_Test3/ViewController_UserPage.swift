//
//  ViewController_UserPage.swift
//  PHP_Test3
//
//  Created by Salim on 5/5/20.
//  Copyright © 2020 Salim3dd. All rights reserved.
//

import UIKit

class ViewController_UserPage: UIViewController {

    @IBOutlet weak var Lab_UserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        Lab_UserName.text = "مرحبا : "+LogInUserName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

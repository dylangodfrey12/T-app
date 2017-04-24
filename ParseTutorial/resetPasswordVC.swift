//
//  resetPasswordVC.swift
//  ParseTutorial
//
//  Created by Dylan Godfrey on 3/22/17.
//  Copyright © 2017 Ron Kliffer. All rights reserved.
//

import UIKit

class resetPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    
  
    @IBOutlet weak var resetBtn: UIButton!

    @IBOutlet weak var cancelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //reset button clicked
    @IBAction func resetBtn_click(_ sender: Any) {
      
self.view.endEditing(true)
      
      if emailTxt.text!.isEmpty {
        
        let alert = UIAlertController(title: "Please", message: "fill in all fields", preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) in
          self.dismiss(animated: true, completion: nil)
        })
       alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
      }
      
      PFUser.requestPasswordResetForEmail(inBackground: emailTxt.text!) { (success, error) in
        if success {
          
          let alert = UIAlertController(title: "Email Has Been Sent", message: "please check your mail box", preferredStyle: .alert)
          
          let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
          })
        
        alert.addAction(ok)
          self.present(alert, animated: true, completion: nil)
        }
        else { print(error!.localizedDescription)
      }
      }
    }
    @IBAction func cancelBtn_click(_ sender: Any) {
      
self.view.endEditing(true)
      
      self.dismiss(animated: true, completion: nil)
  
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  signInVC.swift
//  ParseTutorial
//
//  Created by Dylan Godfrey on 3/22/17.
//  Copyright © 2017 Ron Kliffer. All rights reserved.
//

import UIKit
import Parse

class signInVC: UIViewController {
    //text fields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    //buttons
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInBtn_click(_ sender: Any) {
        print("sign in clicked")
      
      self.view.endEditing(true)
      
      //if text fields empty
      if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
        
        //show alert options
        let alert = UIAlertController(title: "Please", message: "fill in fields", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
        //login functions
        PFUser.logInWithUsername(inBackground: usernameTxt.text!, password: passwordTxt.text!) { (user:PFUser?, error:Error?) -> Void in
          if error == nil {
            
              print(error?.localizedDescription)
            print("login successful")
            NSLog("logged in")
          }
        }
        
      }
    }
  
  @IBAction func signUpBtn_click(_ sender: Any) {
    print("sign up clicked")
  }
  @IBAction func forgotBtn_click(_ sender: Any) {
    print("forgot password clicked")
    
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

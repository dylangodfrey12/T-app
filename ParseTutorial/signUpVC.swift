//
//  sigUpVC.swift
//  ParseTutorial
//
//  Created by Dylan Godfrey on 3/22/17.
//  Copyright © 2017 Ron Kliffer. All rights reserved.
//

import UIKit
import Parse

class signUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //avatar image
    @IBOutlet weak var avaImg: UIImageView!
    
    //textfields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatpasswordTxt: UITextField!
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var repeatemailTxt: UITextField!
   @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var zipcodeTxt: UITextField!
    @IBOutlet weak var phonenumberTxt: UITextField!
    
    //scrollview UI
    @IBOutlet weak var scrollView: UIScrollView!
  
  //define keyboard frame
    var keyboard = CGRect()
  
  //intial scroll view height
  var scrollViewHeight :CGFloat = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
      
      scrollView.contentSize.height = self.view.frame.height
      scrollViewHeight = scrollView.frame.size.height
      
      //check notification if keyboard is shown or not
      NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: .UIKeyboardWillShow, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: .UIKeyboardWillShow, object: nil)

     
        // Do any additional setup after loading the view.
      let hideTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap))
      //number taps to hidekeyboard
      hideTap.numberOfTapsRequired = 1
      //allows users to interact with screen
      self.view.isUserInteractionEnabled = true
      self.view.addGestureRecognizer(hideTap)
      
      avaImg.layer.cornerRadius = avaImg.frame.size.width / 2
      avaImg.clipsToBounds = true
      
      //when the image is tapped
      let avaTap = UITapGestureRecognizer(target: self, action: #selector(loadImg))
      avaTap.numberOfTapsRequired = 1
      self.view.isUserInteractionEnabled = true
      self.view.addGestureRecognizer(avaTap)
    }
  
  //when avaTap is called load image from photos
  func loadImg(recognizer: UITapGestureRecognizer) {
    //imgPicker to select image
    let imgPicker = UIImagePickerController()
    imgPicker.delegate = self
    imgPicker.sourceType = .photoLibrary
    imgPicker.allowsEditing = true
    present(imgPicker, animated: true, completion: nil)
  }
  
  //choose profile pic from gallery
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
    self.dismiss(animated: true, completion: nil)
  }
  
  //hide keyboard if tapped
  func hideKeyboardTap(recognizer: UITapGestureRecognizer) {
    self.view.endEditing(true)
    
  }

  func showKeyboard (notification:NSNotification) {

    //set default keyboard height
    keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
    
    UIView.animate(withDuration: 0.4) { 
      self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.height
    }
  }
  
  func hideKeyboard (notification:NSNotification) {
    
    //set keyboard height
    keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)
    
    self.scrollView.frame.size.height = self.view.frame.height
  }
  
    @IBAction func signUpBtn_click(_ sender: Any) {
      
      //dismiss keyboard
      self.view.endEditing(true)
      
      if (usernameTxt.text!.isEmpty||passwordTxt.text!.isEmpty||repeatpasswordTxt.text!.isEmpty||fullnameTxt.text!.isEmpty||emailTxt.text!.isEmpty||repeatemailTxt.text!.isEmpty||addressTxt.text!.isEmpty||stateTxt.text!.isEmpty||cityTxt.text!.isEmpty||zipcodeTxt.text!.isEmpty||phonenumberTxt.text!.isEmpty) {
        
        let alert = UIAlertController(title: "Please", message: "Fill in all fields", preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
      }
      
      //if passwords do not match
      if (passwordTxt.text! != repeatpasswordTxt.text!){
        let alert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
      }
      
      //if emails do not match
      if (emailTxt.text! != repeatemailTxt.text!){
        let alert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
      }
      //username password email come with parse
      let user = PFUser()
      user.username = usernameTxt.text?.lowercased()
      user.password = passwordTxt.text
      user.email = emailTxt.text?.lowercased()
      
      //must define other parse variables or column here:
      user["fullname"] = fullnameTxt.text?.lowercased()
      user["address"] = addressTxt.text
      user["state"] = stateTxt.text
      user["city"] = cityTxt.text
      user["zipcode"] = zipcodeTxt.text
      user["phonenumber"] = phonenumberTxt.text
     
      //in edit profile its gonna be assigned
      user["tel"] = ""
      
      //send profile picture in edi
      
      
      //convert our image for sending to server
      let avaData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
      let avaFile = PFFile(name: "ava.jpg", data: avaData!)
      user["ava"] = avaFile
      
      //save data in server
      user.signUpInBackground { (success, error) -> Void in
        
      
        if success {
          //remember logged user
          UserDefaults.standard.set(user.username, forKey: "username")
          UserDefaults.standard.synchronize()
          
          // call login func from AppDelegate.swift class
          let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
          appDelegate.login()
        } else {
          print(error?.localizedDescription)
        }
      }
      
    }
    
    @IBAction func cancelBtn_click(_ sender: Any) {
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

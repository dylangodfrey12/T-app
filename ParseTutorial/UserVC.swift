//
//  UserVC.swift
//  ParseTutorial
//
//  Created by Dylan Godfrey on 4/19/17.
//  Copyright © 2017 Ron Kliffer. All rights reserved.
//

import UIKit
import Parse

class UserVC: UICollectionViewController {

  var refresher: UIRefreshControl!
  
  //hold arrays
  var uuidArray = [String]()
  var picArray = [PFFile]()
  
  var pageSize : Int = 12
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.collectionView?.alwaysBounceVertical = true
      
      //bg color
      collectionView?.backgroundColor = .white
      
      
      self.navigationItem.title = PFUser.current()?.username?.uppercased()
      
      //pull to refresh
      refresher.addTarget(self, action: #selector(UserVC.), for: <#T##UIControlEvents#>)
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

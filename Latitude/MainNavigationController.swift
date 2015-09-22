//
//  MainNavigationController.swift
//  Latitude
//
//  Created by Ng Zouyiu on 15/9/21.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = UserInfo.force == Force.One ? Colors.forceOne() : Colors.forceTwo()
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

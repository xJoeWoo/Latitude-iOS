//
//  MainViewController.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/15.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MAMapViewDelegate {
    
    var mapView: MAMapView!
    
    @IBOutlet var viewMapContainer: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = false
        
        title = "WeMore"
        
        mapView = MAMapView(frame: viewMapContainer.bounds)
        mapView.delegate = self
        viewMapContainer.addSubview(mapView)
        
        navigationController?.navigationBar.barTintColor = UserInfo.force == Force.One ? Colors.forceOne() : Colors.forceTwo()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

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

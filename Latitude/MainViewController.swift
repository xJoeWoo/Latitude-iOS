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
    var scoreView: ScoreView!
    
    @IBOutlet var btnBarLeft: UIBarButtonItem!
    @IBOutlet var btnBarAdd: UIBarButtonItem!
    @IBOutlet var viewMapContainer: UIView!
    
    @IBAction func setSpot() {
        scoreView.setPlayerScore(++UserInfo.playerScore)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 关闭导航左边按钮响应
        btnBarLeft.enabled = false
        btnBarLeft.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Disabled)
        
        // 左边按钮标题
        btnBarLeft.title = UserInfo.name
        
        // 初始化、添加地图
        mapView = MAMapView(frame: viewMapContainer.bounds)
        mapView.delegate = self
        viewMapContainer.addSubview(mapView)
        
        
        
        // 初始化状态栏上的 ScoreView
        scoreView = ScoreView()
        navigationItem.titleView = scoreView
        
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

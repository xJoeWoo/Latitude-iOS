//
//  ViewController.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/5.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class LoginViewController: UIViewController {
    
    @IBOutlet var viewContainer:UIView!
    @IBOutlet var tfUsername:UITextField!
    @IBOutlet var tfPassword:UITextField!
    @IBOutlet var btnLogin:UIButton!
    @IBOutlet var btnLogon:UIButton!
    @IBOutlet var tfPasswordConfirm:UITextField!
    @IBOutlet var tfName:UITextField!
    
    @IBOutlet var btnLoginTopSpace: NSLayoutConstraint!
    @IBOutlet var btnLogonTopSpace: NSLayoutConstraint!
    
    
    var isNewUser = false
    
    /**
    登录按钮点击响应
    */
    @IBAction func btnLogin_TouchUpInside() {
        if checkInputs() {
            
            HttpModel.getJson(HttpModel.Urls.LOGIN, getInputs()) { (result) -> Void in
                switch (result){
                case let .Error(e):
                    ()
                    // TODO: 网络错误
                    
                case let .Value(json):
                    
                    if let state = json[HttpModel.Params.TOKEN].int {
                        
                        UserInfo.account = json[HttpModel.Params.ACCOUNT].stringValue
                        UserInfo.id = json[HttpModel.Params.ID].intValue
                        UserInfo.token = json[HttpModel.Params.TOKEN].stringValue
                        UserInfo.force = json[HttpModel.Params.FORCE].intValue
                        UserInfo.score = json[HttpModel.Params.SCORE_PLAYER].intValue
                        UserInfo.fscore = json[HttpModel.Params.SCORE_FORCE].intValue
                        UserInfo.name = json[HttpModel.Params.NAME].stringValue
                        
                        // TODO: 登录成功
                        
                    } else {
                        self.isNewUser = true;
                        self.btnLogin.enabled = false
                        self.expendContainer()
                    }
                }
            }
        }
    }
    
    /**
    注册按钮点击响应
    */
    @IBAction func btnLogon_TouchUpInside() {
        if checkInputs() {
            if !isNewUser { // 直接点击注册需展开
                
                self.isNewUser = true;
                self.btnLogin.enabled = false
                self.expendContainer()
                
            } else { // 展开信息完整后发起注册请求
                
                HttpModel.getJson(HttpModel.Urls.LOGON, getInputs()) { (result) -> Void in
                    switch (result){
                    case let .Error(e):
                        ()
                        // TODO: 网络错误

                    case let .Value(json):
                        
                        if let state = json[HttpModel.Params.STATE].int{
                            
                            if state == 1 { // 注册成功
                                
                                // TODO: 注册成功

                            }
                        }
                    }
                }
            }
        }
    }
    
    /**
    帐号输入框按下 Next 响应
    */
    @IBAction func tfUsername_DidEndOnExit() {
        tfPassword.becomeFirstResponder()
    }
    
    /**
    帐号输入框按下 Done 响应
    */
    @IBAction func tfPassword_DidEndOnExit() {
        if !isNewUser {
            btnLogin.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
    }
    
    /**
    密码确认输入框按下 Next 响应
    */
    @IBAction func tfPasswordConfirm_DidEndOnExit() {
        tfName.becomeFirstResponder()
    }
    
    /**
    昵称输入框按下 Done 响应
    */
    @IBAction func tfName_DidEndOnExit() {
        btnLogon.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    /**
    检查输入
    */
    func checkInputs() -> Bool {
        var flag = false
        
        if tfUsername.hasText() && tfPassword.hasText() {
            if !isNewUser {
                flag = true
            } else {
                if tfPasswordConfirm.hasText() && tfName.hasText() && (tfPasswordConfirm.text == tfPassword.text) {
                    flag = true
                }
            }
        }
        
        if !flag {
            if !tfUsername.hasText() {
                shakeView(tfUsername)
            }
            if !tfPassword.hasText() {
                shakeView(tfPassword)
            }
            if !tfPasswordConfirm.hasText() {
                shakeView(tfPasswordConfirm)
            }
            if !tfName.hasText() {
                shakeView(tfName)
            }
            if isNewUser && tfPassword.text != tfPasswordConfirm.text {
                shakeView(tfPassword)
                shakeView(tfPasswordConfirm)
            }
        }
        
        return flag
    }
    
    /**
    取得输入
    */
    func getInputs() -> Dictionary<String, String> {
        var dict = Dictionary<String, String>()
        dict[HttpModel.Params.ACCOUNT] = tfUsername.text
        dict[HttpModel.Params.PASSWORD] = tfPasswordConfirm.text
        if tfName.hasText() {
            dict[HttpModel.Params.NAME] = tfName.text
        }
        return dict
    }
    
    /**
    摇动 View
    */
    func shakeView(view:UIView) {
        
        tfPassword.secureTextEntry = false
        tfPasswordConfirm.secureTextEntry = false
        
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( CATransform3D:CATransform3DMakeTranslation(-5, 0, 0 ) ),
            NSValue( CATransform3D:CATransform3DMakeTranslation( 5, 0, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 9/100
        anim.delegate = self
        view.layer.addAnimation( anim, forKey:nil )
    }
    
    /**
    动画结束响应
    */
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        tfPassword.secureTextEntry = true
        tfPasswordConfirm.secureTextEntry = true
    }
    
    /**
    展开 Container View
    */
    func expendContainer() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.tfPasswordConfirm.hidden = false
            self.tfName.hidden = false
            self.tfPasswordConfirm.alpha = 1.0
            self.tfName.alpha = 1.0
            
            self.btnLogin.setTitleColor(Colors.greyText(), forState: UIControlState.Normal)
            self.btnLogon.setTitleColor(Colors.greenLatitude(), forState: UIControlState.Normal)
            
            self.btnLoginTopSpace.constant += (self.tfPasswordConfirm.frame.size.height + 10) * 2
            self.btnLogonTopSpace.constant += (self.tfPasswordConfirm.frame.size.height + 10) * 2
            self.viewContainer.layoutIfNeeded()
            
            }) { (finished) -> Void in
                self.tfPasswordConfirm.becomeFirstResponder()
        }
    }
    
    
    override func viewDidLoad() {
        
        // 白色背景圆角、阴影
        viewContainer.layer.cornerRadius = 4
        viewContainer.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewContainer.layer.shadowOpacity = 0.2
        viewContainer.layer.shadowRadius = 3.0
        
        // 避开弹出的软键盘
        IHKeyboardAvoiding.setAvoidingView(viewContainer)
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


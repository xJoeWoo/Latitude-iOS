//
//  ViewController.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/5.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class LoginViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var viewContainer:UIView!
    @IBOutlet var tfAccount:UITextField!
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
            blinkView(btnLogin, true)
            HttpModel.getJson(HttpModel.Urls.Login, getInputs()) { (result) -> Void in
                self.blinkView(self.btnLogin, false)
                switch (result){
                case let .Error(e):
                    ()
                    // TODO: 网络错误
                    
                case let .Value(json):
                    
                    if let state = json[HttpModel.Params.Token].string {
                        
                        UserInfo.account = json[HttpModel.Params.Account].stringValue
                        UserInfo.id = json[HttpModel.Params.Id].intValue
                        UserInfo.token = json[HttpModel.Params.Token].stringValue
                        UserInfo.force = json[HttpModel.Params.Force].intValue == 1 ? Force.One : Force.Two
                        UserInfo.playerScore = json[HttpModel.Params.PlayerScore].intValue
                        UserInfo.forceScore = json[HttpModel.Params.ForceScore].intValue
                        UserInfo.name = json[HttpModel.Params.Name].stringValue
                        
                        PreferenceModel.saveString(PreferenceModel.Keys.UserName, value: UserInfo.account)
                        
//                        self.navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController, animated: true)
                        
                        self.performSegueWithIdentifier("SegueToNav", sender: self)
                        
                        // TODO: 登录成功
                        
                    } else {
                        if self.isNewUser { // 注册后自动登录
                            
                            // TODO: 登录错误
                            
                        } else { // 未注册用户登录
                            self.isNewUser = true;
                            self.btnLogin.enabled = false
                            self.expendContainer()
                        }
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
                
                let chooseForceAlert = UIAlertView(title: "决定团队", message: "请决定您的团队", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "Force One", "Force Two")
                
                chooseForceAlert.show()
                
            }
        }
    }
    
    
    /**
    帐号输入框按下 Next 响应
    */
    @IBAction func tfAccount_DidEndOnExit() {
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
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        PreferenceModel.saveString(PreferenceModel.Keys.UserName, value: "")
        return true
    }
    
    /**
    选择团队 UIAlertView 响应
    */
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        var params = getInputs()
        params[HttpModel.Params.Force] = String(buttonIndex)
        
        blinkView(btnLogon, true)
        
        HttpModel.getJson(HttpModel.Urls.Logon, params) { (result) -> Void in
            
            self.blinkView(self.btnLogon, false)
            
            switch (result){
            case let .Error(e):
                ()
                // TODO: 网络错误
                
            case let .Value(json):
                
                if let state = json[HttpModel.Params.State].int{
                    
                    if state == 1 { // 注册成功
                        NSLog("Logon Succeed")
                        self.btnLogin.enabled = true
                        self.btnLogin.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
                        
                    }
                } else {
                    println(json[HttpModel.Params.State].error)
                }
            }
        }
    }
    
    /**
    检查输入
    */
    private func checkInputs() -> Bool {
        var flag = false
        
        if tfAccount.hasText() && tfPassword.hasText() {
            if !isNewUser {
                flag = true
            } else {
                if tfPasswordConfirm.hasText() && tfName.hasText() && (tfPasswordConfirm.text == tfPassword.text) {
                    flag = true
                }
            }
        }
        
        if !flag {
            if !tfAccount.hasText() {
                shakeView(tfAccount)
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
    private func getInputs() -> Dictionary<String, String> {
        var dict = Dictionary<String, String>()
        dict[HttpModel.Params.Account] = tfAccount.text
        dict[HttpModel.Params.Password] = tfPasswordConfirm.text
        if tfName.hasText() {
            dict[HttpModel.Params.Name] = tfName.text
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
        anim.duration = 9 / 100
        anim.delegate = self
        view.layer.addAnimation( anim, forKey:nil )
    }
    
    /**
    闪烁 View
    */
    func blinkView(view: UIView, _ start: Bool) {
        if start {
            UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                if view.alpha == 1 {
                    view.alpha = 0
                } else {
                    view.alpha = 1
                }
                }, completion: nil)
        } else {
            view.layer.removeAllAnimations()
            UIView.animateWithDuration(0.1) { () -> Void in
                view.alpha = 1
            }
        }
        
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
    private func expendContainer() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.tfPasswordConfirm.hidden = false
            self.tfName.hidden = false
            self.tfPasswordConfirm.alpha = 1.0
            self.tfName.alpha = 1.0
            
            self.btnLogin.setTitleColor(Colors.greyText(), forState: UIControlState.Normal)
            self.btnLogon.setTitleColor(Colors.greenLatitude(), forState: UIControlState.Normal)

            let btnLogonX = NSLayoutConstraint(item: self.btnLogon, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.viewContainer, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
            btnLogonX.priority = 600
            btnLogonX.active = true
            
            let btnLogonWidth = NSLayoutConstraint(item: self.btnLogon, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.viewContainer, attribute: NSLayoutAttribute.Width, multiplier: 0.9, constant: 0)
            btnLogonWidth.priority = 600
            btnLogonWidth.active = true
            
            self.btnLogin.hidden = true
            
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
        
        // 加载已登录用户名
        if let username = PreferenceModel.getString(PreferenceModel.Keys.UserName) {
            tfAccount.text = username
        }
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


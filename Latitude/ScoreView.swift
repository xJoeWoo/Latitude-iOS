//
//  ScoreView.swift
//  Latitude
//
//  Created by Ng Zouyiu on 15/9/22.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    
    @IBOutlet var devider: UILabel!
    @IBOutlet var player: UILabel!
    @IBOutlet var force: UILabel!
    
    @IBOutlet var playerCenterY: NSLayoutConstraint!
    @IBOutlet var forceCenterY: NSLayoutConstraint!
    
    convenience init() {
        self.init(frame: CGRect.zeroRect)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        updateScores()
    }
    
    func updateScores() {
        if player.text != String(UserInfo.playerScore) {
            setPlayerScore(UserInfo.playerScore)
        }
        if force.text != String(UserInfo.forceScore) {
            setForceScore(UserInfo.forceScore)
        }
    }
    
    func setPlayerScore(score: Int) {
        setScoreWithAnim(score, player)
        
    }
    
    func setForceScore(score: Int) {
        setScoreWithAnim(score, force)
    }
    
    private func setScoreWithAnim(score: Int, _ label: UILabel) {
        
        var constraint = label == player ? playerCenterY : forceCenterY
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            constraint.constant -= 30
            label.alpha = 0
            label.transform = CGAffineTransformMakeScale(0.3, 0.3)
            label.layoutIfNeeded()
            
            }, completion: { (finished) -> Void in
                
                constraint.constant += 60
                label.layoutIfNeeded()
                label.text = String(score)
                
                UIView.animateWithDuration(0.3){ () -> Void in
                    
                    constraint.constant -= 30
                    label.alpha = 1
                    label.transform = CGAffineTransformMakeScale(1, 1)
                    label.layoutIfNeeded()
                }
        })
        
        
    }
    
    private func commonInit() {
        var nibView = NSBundle.mainBundle().loadNibNamed("ScoreView", owner: self, options: nil)[0] as! UIView
        nibView.frame = bounds
        addSubview(nibView)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}

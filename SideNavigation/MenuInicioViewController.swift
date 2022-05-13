//
//  ViewController.swift
//  SideNavigation
//
//  Created by Resembrink Correa on 12/05/22.
//

import UIKit

class MenuInicioViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rightSideMenu: UIView!
    @IBOutlet weak var leftSideMenu: UIView!
    
    @IBOutlet weak var leftSideMenuLeadingAnchor: NSLayoutConstraint!
    @IBOutlet weak var rigthtSideTraillingAnchor: NSLayoutConstraint! // cero por defecto
    
    @IBOutlet weak var widthSideMenuLeading: NSLayoutConstraint!
    
    private var anchorWidth:CGFloat = 0.0
    private var dimen_porcent:CGFloat = 0
    private var dimen_total_right:CGFloat = 0
    private var dimen_total_left:CGFloat = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        leftSideMenuLeadingAnchor.constant = 0
        anchorWidth = UIScreen.main.bounds.size.width // 100% //810
        print(anchorWidth)
        dimen_porcent = (anchorWidth * 20)/100
        dimen_total_left = anchorWidth - dimen_porcent
        print(dimen_total_left)  //648
         dimen_total_right = anchorWidth - dimen_total_left //162
        
        print(dimen_total_right)
        leftSideMenu.widthAnchor.constraint(equalToConstant: dimen_total_left).isActive  = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        rightSideMenu.addGestureRecognizer(tapGesture)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        mainView.addGestureRecognizer(panGesture)
    }
    
  
    
    
    @objc func panGestureAction(sender: UIPanGestureRecognizer){
        if sender.state == .began {
            
        } else if sender.state == .ended {
            
            leftSideMenuLeadingAnchor.constant = leftSideMenuLeadingAnchor.constant < -175 ? -300 : 0
            if leftSideMenuLeadingAnchor.constant < -175 {
                leftSideMenuLeadingAnchor.constant = -300
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            } else {
                showViewAnimation()
            }
            
        } else {
            if leftSideMenuLeadingAnchor.constant == -300 {
                if sender.location(in: mainView).x > 30 {
                    return
                }
            }
            
            if sender.location(in: mainView).x <= 300 {
                leftSideMenuLeadingAnchor.constant = -300 + sender.location(in: mainView).x
                if leftSideMenuLeadingAnchor.constant < -10 {
                    rigthtSideTraillingAnchor.constant = -114
                }else {
                    rigthtSideTraillingAnchor.constant = 0
                }
                
            }
        }
        
        func showViewAnimation(){
            leftSideMenuLeadingAnchor.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }) { (_) in
                self.rigthtSideTraillingAnchor.constant = 0
            }
        }
        
    }
    
    @objc func tapGestureAction(){
        leftSideMenuLeadingAnchor.constant = -300
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            DispatchQueue.main.async {
                self.rigthtSideTraillingAnchor.constant = -114
                
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) {
                    self.view.layoutIfNeeded()
                }
                
            }
           
        }
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        
       
        
//
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        } completion: { Bool in
//            DispatchQueue.main.async {
//                self.rigthtSideTraillingAnchor.constant = 0
//                UIView.animate(withDuration: 0.1)  {
//                    self.view.layoutIfNeeded()
//                }
//            }
//        }
//
    }
    
    
    
}


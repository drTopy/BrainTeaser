//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Thiago Costa on 3/30/16.
//  Copyright © 2016 Thiago Costa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
        
    }

    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
    }

}


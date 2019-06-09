//
//  ViewController.swift
//  game-button
//
//  Created by Charles Zillmann on 6/6/19.
//  Copyright © 2019 Charles Zillmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn1: StylizedGameButton!
    @IBOutlet weak var btn2: StylizedGameButton!
    @IBOutlet weak var btn3: StylizedGameButton!
    @IBOutlet weak var btn4: StylizedGameButton!
    //***************************************************************
    //***************        override func viewDidLoad()
    //***************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomizedButtons()
        
    }  // override func viewDidLoad()
    
    //***************************************************************
    //***************        func setupCustomizedButtons()
    //***************************************************************
    func setupCustomizedButtons() {
        btn1.setButtonStyle( btnstyle : ButtonStyle.Style1)
        btn2.setButtonStyle( btnstyle : ButtonStyle.Style2)
        btn3.setButtonStyle( btnstyle : ButtonStyle.Style3)
        btn4.setButtonStyle( btnstyle : ButtonStyle.Style4)
    }  // func setupCustomizedButtons()
    
    //***************************************************************
    //***************        @IBAction func gamebuttonPressed(_ button: CustomizedGameButton)
    //***************************************************************
    @IBAction func gamebuttonPressed(_ button: StylizedGameButton) {
        
        button.changeState()
        
    }  // @IBAction func gamebuttonPressed(_ button: CustomizedGameButton)
    
}  // class ViewController: UIViewController 


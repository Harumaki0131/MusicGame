//
//  score2ViewController.swift
//  Musicgame
//
//  Created by EriyaMurakami on 2016/08/05.
//  Copyright © 2016年 EriyaMurakami. All rights reserved.
//

import UIKit

class score4ViewController: UIViewController {
    
    
    var number: Int = 0
    @IBOutlet var scorelabel: UILabel!
    
    override func viewDidLoad(){
        //画面が最初に起動したときに呼び出される
        super.viewDidLoad()
        var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //        delegate.scoreTotal
        scorelabel.text = String(delegate.scoreTotal)
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




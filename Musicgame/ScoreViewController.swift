//
//  ScoreViewController.swift
//  Musicgame
//
//  Created by EriyaMurakami on 2016/08/04.
//  Copyright © 2016年 EriyaMurakami. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

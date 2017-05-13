//
//  ViewControllerhome.swift
//  Musicgame
//
//  Created by EriyaMurakami on 2016/09/24.
//  Copyright © 2016年 EriyaMurakami. All rights reserved.
//

import UIKit

class ViewControllerhome: UIViewController {
    
    
    
    @IBOutlet weak var senntakuBUtton: UIButton!
    @IBOutlet weak var gakkougurasiButtton: UIButton!
    @IBOutlet weak var INNOCENCEButtton: UIButton!
    @IBOutlet weak var kuropngImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func pushSenntaku(sender: AnyObject) {
        
        senntakuBUtton.hidden = true
        gakkougurasiButtton.hidden = false
        INNOCENCEButtton.hidden = false
        kuropngImageView.hidden = false
        
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

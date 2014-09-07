//
//  DebugViewController.swift
//  TracePath
//
//  Created by Cofyc on 9/7/14.
//
//

import UIKit

class DebugViewController: UIViewController {

    @IBOutlet var logScreen: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.logScreen.text = ""
        self.logScreen.textColor = UIColor.redColor()
        self.logScreen.font = UIFont(name: "Monaco", size: 12.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func log(message: String) {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // GMT +8
        let log = "[%@] %@".format(formatter.stringFromDate(date), message)
        // console
        println(log)
        // on screen
        self.logScreen.text = self.logScreen.text.stringByAppendingString(log + "\n")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

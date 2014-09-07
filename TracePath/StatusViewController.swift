//
//  StatusViewController.swift
//  TracePath
//
//  Created by Cofyc on 9/8/14.
//
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet var latitude: UITextField!
    @IBOutlet var longitude: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func update(latitude:CLLocationDegrees, longitude:CLLocationDegrees) {
        self.latitude.text = "lat: %.8f".format(latitude)
        self.longitude.text = "lon: %.8f".format(longitude)
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

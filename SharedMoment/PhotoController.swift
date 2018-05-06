//
//  PhotoController.swift
//  SharedMoment
//
//  Created by christophe milliere on 06/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {

    @IBOutlet weak var sharedButton: UIBarButtonItem!
    @IBOutlet weak var photoShared: UIImageView!
    @IBOutlet weak var textShared: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonAction(_ sender: Any) {
    }
    
}

//
//  SecondViewController.swift
//  SimpleTable
//
//  Created by kwon on 2021/08/02.
//

import UIKit

class SecondViewController: UIViewController {
    
    var textToSet: String?
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.label.text = self.textToSet
    }
}

//
//  DetailViewController.swift
//  RIP
//
//  Created by Brian Hill on 11/22/16.
//  Copyright © 2016 cs197. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UITextView!

    @IBOutlet weak var rating: UILabel!

    @IBOutlet weak var productID: UILabel!
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail
            }
        }
        if let ratingGiven = self.ratingOf {
            if let label = self.rating {
                rating.text = String(ratingGiven)
            }
        }
        if let productNum = self.product {
            if let label = self.productID {
                label.text = productNum
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    var ratingOf: Int? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    var product: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

}


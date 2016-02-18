//
//  DetailViewController.swift
//  QuoteProPlus
//
//  Created by Anthony Tulai on 2016-02-18.
//  Copyright © 2016 Anthony Tulai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var mainImage = UIImage ()

//    var detailItem: AnyObject? {
//        didSet {
//            // Update the view.
//            self.configureView()
//        }
//    }

//    func configureView() {
//        // Update the user interface for the detail item.
//        if let detail = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.valueForKey("timeStamp")!.description
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainImageView = UIImageView()
        mainImageView.frame = self.view.bounds
        mainImageView.image = self.mainImage
        self.view.addSubview(mainImageView)

        // Do any additional setup after loading the view, typically from a nib.
       // self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


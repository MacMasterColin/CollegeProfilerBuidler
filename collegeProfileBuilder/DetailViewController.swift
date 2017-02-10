//
//  DetailViewController.swift
//  collegeProfileBuilder
//
//  Created by cmacgregor on 2/6/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var populationTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var detailItem: College? {
        didSet {
            // Update the view.
            self.configureView()
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

    func configureView() {
        // Update the user interface for the detail item
        if let college = self.detailItem {
            if nameTextField != nil {
                nameTextField.text = college.name
                locationTextField.text = college.location
                populationTextField.text = String(college.population)
                imageView.image = UIImage(data: college.image)
            }
        }
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    if let college = self.detailItem {
        college.name = nameTextField.text!
        college.location = locationTextField.text!
        college.population = Int(populationTextField.text!)!
        college.image = UIImagePNGRepresentation(imageView.image!)!
        }
    }
}

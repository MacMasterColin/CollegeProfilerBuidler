//
//  DetailViewController.swift
//  collegeProfileBuilder
//
//  Created by cmacgregor on 2/6/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var populationTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    let realm = try! Realm()
    let imagePicker = UIImagePickerController()
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
        imagePicker.delegate = self
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true) { 
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.imageView.image = selectedImage
        }
    }
        
    @IBAction func ChangePhotoButton(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    if let college = self.detailItem {
        try! realm.write({
          college.name = nameTextField.text!
        college.location = locationTextField.text!
        college.population = Int(populationTextField.text!)!
        college.image = UIImagePNGRepresentation(imageView.image!)!
            })
        }
    }
}

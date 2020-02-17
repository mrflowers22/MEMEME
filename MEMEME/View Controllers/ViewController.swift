//
//  ViewController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/17/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButtonProperties: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        cameraButtonProperties.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    @IBAction func shareButttonTapped(_ sender: UIBarButtonItem) {
        //save new photo to library
    }
    
    @IBAction func cancelMemeButtonTapped(_ sender: UIBarButtonItem) {
        //clear everything
        photoImage.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        //check to see if device has camera - if not disable button
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //REFACTOR
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
    
    @IBAction func albumButtonTapped(_ sender: UIBarButtonItem) {
        //open up photoLibrary -REFACTOR
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let choosenImage = info[.originalImage] as? UIImage else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        photoImage.image = choosenImage
        dismiss(animated: true)
    }
    
}


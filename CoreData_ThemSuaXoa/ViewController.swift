//
//  ViewController.swift
//  CoreData_ThemSuaXoa
//
//  Created by Just Kidding on 4/9/19.
//  Copyright © 2019 Just Kidding. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //MARK: Properties
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var data: Person?
    var index: Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let objectData = data {
            txtName.text = objectData.name
            txtAge.text = String(objectData.age)
            imageView.image = objectData.image as? UIImage
        }
    }
    


    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss neu nguoi dung chon cancel
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Error: \(info)")
        }
        
        //dat imageView  de hien thi anh da duoc chon
        imageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    //MARK: - Actions
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        //UIImagePickerController là một view controller cho phép người dùng có thể pick media từ thư viện ảnh
        let imagePickerController = UIImagePickerController()
        
        //Chỉ cho phép chọn ảnh không chop chup
        imagePickerController.sourceType = .photoLibrary
        
        //uỷ quyền cho nó để nó thưcj hiện được
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func buttonAddData(_ sender: Any) {
        if index == nil {
            let data = Person(context: AppDelegate.context)
            if let content = txtName.text {
                data.name = content
            }
            if let content = txtAge.text {
                data.age = Int32(content) ?? 0
            }
            if let content = imageView.image {
                data.image = content
            }
        } else {
            data?.setValue(txtName.text, forKey: "name")
            data?.setValue(Int(txtAge.text!), forKey: "age")
            data?.setValue(imageView.image, forKey: "image")
        }
        
        
        AppDelegate.saveContext()
        
       dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
}


//
//  PhotoController.swift
//  SharedMoment
//
//  Created by christophe milliere on 06/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var sharedButton: UIBarButtonItem!
    @IBOutlet weak var photoShared: UIImageView!
    @IBOutlet weak var textShared: UITextView!
    
    let textEmpty = "Entrez un texte..."
    var imagePicker: UIImagePickerController?
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        photoShared.contentMode = .scaleAspectFill
        photoShared.image = #imageLiteral(resourceName: "Superman-facebook.svg")
        photoShared.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickPhoto))
        photoShared.addGestureRecognizer(tap)
        
        textShared.text = textEmpty
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
        
        textShared.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textEmpty {
            textView.text = ""
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image: UIImage?
        if let edit = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = edit
        } else if let original = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = original
        }
        
        photoShared.image = image
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickPhoto(){
        guard imagePicker != nil else { return }
        let alerte = UIAlertController(title: "Prendre un photo", message: "Choisir le media", preferredStyle: .actionSheet)
        let device = UIAlertAction(title: "Appareil Photo", style: .default) { (act) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                self.imagePicker?.sourceType = .camera
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        
        let library = UIAlertAction(title: "Librairie de photo", style: .default) { (act) in
            self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alerte.addAction(device)
        alerte.addAction(library)
        alerte.addAction(cancel)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = alerte.popoverPresentationController {
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.minX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
        }
        self.present(alerte, animated: true, completion: nil)
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        var contentShared: [Any] = [Any]()
        
        if let image = photoShared.image, image != #imageLiteral(resourceName: "Superman-facebook.svg") {
            contentShared.append(image)
        }
        
        if textShared.text != "", textShared.text != textEmpty {
            contentShared.append(textShared.text)
        }
        
        let activity = UIActivityViewController(activityItems: contentShared, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = activity.popoverPresentationController {
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.minX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
        }
        self.present(activity, animated: true) {
            self.setup()
        }
    }
    
    
    
    
}

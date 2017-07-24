//
//  ViewController.swift
//  MyApp
//
//  Created by Jenny Yu on 7/17/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate {
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func takingPhoto(_ sender: Any) {
        // 2
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
                                                       message: nil, preferredStyle: .actionSheet)
        // 3
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker,
                                                             animated: true,
                                                             completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker,
                                                         animated: true,
                                                         completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        // 5
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        // 6
        present(imagePickerActionSheet, animated: true,
                completion: nil)

    }
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        func performImageRecognition(image: UIImage) {
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            tesseract.pageSegmentationMode = .auto
            //tesseract.image = UIImage(named: "HarryPotter")?.g8_blackAndWhite()
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize()

            
            let listOfIngredients: [String] = ["harry", "wand", "potter"]
            //let thisString = textView.text.lowercased()
            let convertedText = tesseract.recognizedText.lowercased()
            //print(thisString)
            
            print(textView.text)
            
            if (textView.text) != nil {
                let parts = convertedText.words//thisString?.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
                print(parts)
                var sentenceAsDictionary:[String:Bool] = [:]
                
                sentenceAsDictionary["chair"] = true
                
                
                for aWord in parts{
                    sentenceAsDictionary[aWord] = true
                    
                }
                
                for anIngredient in listOfIngredients {
                    
                    if sentenceAsDictionary[anIngredient] == true{
                        print(anIngredient)
                    }
                    
                }
                
            }
        }
    }
}
    

    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

extension String {
    var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespacesAndNewlines)
            
            .filter{!$0.isEmpty}
    }
}

//extension ViewController: UIImagePickerControllerDelegate {
//    func imagePickerController(picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let scaledImage = scaleImage(image: selectedPhoto, maxDimension: 640)
//        
//        
//    }
//}
//

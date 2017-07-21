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
    
    @IBAction func scanNow(_ sender: Any) {
        let listOfIngredients: [String] = ["harry", "wand", "potter"]
        let thisString = textView.text.lowercased()
        //print(thisString)

        print(textView.text)
        if (textView.text) != nil {
            let parts = thisString.words//thisString?.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
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
                
                
                //let newString: String = listOfIngredients[x]
                
                //let thisStringNew: String = parts
                //let thingy = parts?.filter { $0.hasPrefix(listOfIngredients[x]) }
                /*
                for y in 0...(parts?.count)!-1 {
                    if parts?[y] == listOfIngredients[x] {
                   print("has")
                    }
                */
                    //print("doesnt have 1")
                     //print(parts?[y])
                //}
                //print(parts?[x])
            }
            
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            tesseract.pageSegmentationMode = .auto
            tesseract.image = UIImage(named: "HarryPotter")?.g8_blackAndWhite()
            tesseract.recognize()
            textView.text = tesseract.recognizedText
            //textView.isEditable = true
            
            
            //textView.text = turnTesseractOutputIntoString()
            }
        }
    



    
            
    
            
            
            
            //var recognizedFinishedText : String!
    
//            //Set up the extraction function for the text extractoin from the recognizedText
//    func matchesForRegexInText(regex: String!, text: String!) -> [String]{
//                
//                do {
//                    let regex = try NSRegularExpression(pattern: regex, options: [])
//                    let nsString = text as NSString
//                    let results = regex.matches(in: text,
//                                                        options: [], range: NSMakeRange(0, nsString.length))
//                    return results.map { nsString.substring(with: $0.range)}
//                } catch let error as NSError {
//                    print("invalid regex: \(error.localizedDescription)")
//                    return []
//                }
//    }
//    
//            //Function to get zip from the text
//            func turnTesseractOutputIntoString() -> String {
//                //below is the regex pattern to get zipcodes
//                let ingredient = matchesForRegexInText(regex: "\\d{5}(?:[-\\s]\\d{4})?", text: recognizedFinishedText)
//                
//                if ingredient.isEmpty {
//                    return "Could Not Identify, Tap to Enter Zipcode"
//                } else {
//                    return ingredient[0]
//                }
//            }
//            
//
//        // Do any additional setup after loading the view, typically from a nib.
//
    
    
    
    
    
    
    
    
    
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

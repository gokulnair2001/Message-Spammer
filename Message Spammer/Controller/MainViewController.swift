//
//  ViewController.swift
//  Flirt Abstract
//
//  Created by Gokul Nair on 06/09/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import CoreML

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultView: UIImageView!
    
    let textAnalyser = FlirtMessageClassifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView.layer.cornerRadius = 20
        resultView.isHidden = true
    }
    
    @IBAction func checkBtn(_ sender: Any) {
        messageClassifier()
    }
    
}

extension MainViewController{
    
    func messageClassifier(){
        
        var message = [FlirtMessageClassifierInput]()
        
        if let messages = textField.text{
            let messageForClasification = FlirtMessageClassifierInput(text: messages)
            message.append(messageForClasification)
        }
        
        do {
            let prediction = try self.textAnalyser.predictions(inputs: message)
            
            resultView.isHidden = false
            
            for result in prediction{
                
                let res = result.label
                
                if res == "spam"{
                    
                    resultLabel.text = "Spam Message"
                    resultView.image = UIImage(systemName: "eye.slash")
                    resultView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    textField.text?.removeAll()
                    
                }else{
                    
                    resultLabel.text = "Normal Message"
                    resultView.image = UIImage(systemName: "eye")
                    resultView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    textField.text?.removeAll()
                }
                
            }
        } catch  {
            print("error found\(error)")
            
        }
    }
    
}

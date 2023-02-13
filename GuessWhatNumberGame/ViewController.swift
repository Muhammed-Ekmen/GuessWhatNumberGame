//
//  ViewController.swift
//  GuessWhatNumberGame
//
//  Created by Semih Ekmen on 9.02.2023.
//

import UIKit

class ViewController: UIViewController {
    //User Number that will save and ask.
    @IBOutlet weak var userNumberTextField: UITextField!
    @IBOutlet weak var userNumberOnErrorText: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    //Player
    @IBOutlet weak var guessNumberTextField: UITextField!
    @IBOutlet weak var guessNumberOnErrorText: UILabel!
    @IBOutlet weak var tryNumberButton: UIButton!
    //Tools
    @IBOutlet weak var liveText: UILabel!
    @IBOutlet weak var guessImage: UIImageView!
    @IBOutlet weak var infoText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getReady()
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
        if let userNumber = Int(userNumberTextField.text!){
            //No Error
            userNumberOnErrorText.textColor = UIColor.green
            Repo.shared.guessNumber = userNumber
            userNumberFieldSituation()
            userNumberOnErrorText.text = ConstTexts.shared.saved
            liveText.text = String(Repo.shared.live)
            infoText.text = ConstTexts.shared.liveAndYourGuess
        }else{
            userNumberOnErrorText.text = ConstTexts.shared.inValidValue
        }
    }
    
    @IBAction func tryButtonAction(_ sender: UIButton) {
        //firstly, you should check the text type.
        if let guessNumber = Int(guessNumberTextField.text!){
            if Repo.shared.live > 0 {
                guessNumberProcessing(var: guessNumber)
            }
        }else{
            guessNumberOnErrorText.text = ConstTexts.shared.inValidValue
        }
    }
    
    @IBAction func howIsItPlayingAction(_ sender: UIButton) {
    }
    
    //Required structures.
    func getReady(){
        userNumberOnErrorText.text?.removeAll()
        guessNumberOnErrorText.text?.removeAll()
        tryNumberButton.isEnabled = false
        guessNumberTextField.isEnabled = false
        guessImage.isHidden = true
        liveText.text?.removeAll()
        userNumberTextField.isSecureTextEntry = true
        infoText.text = ConstTexts.shared.saveNumberToStartGame
    }
    
    func userNumberFieldSituation(){
        userNumberTextField.isEnabled = !userNumberTextField.isEnabled
        saveButton.isEnabled = !saveButton.isEnabled
    }
    
    func guessNumberProcessing(var guessNumber:Int){
        if guessNumber > Repo.shared.guessNumber {
            // Bigger
            Repo.shared.live-=1
            guessImage.image = UIImage(named: "arrowDown")
        }else if guessNumber < Repo.shared.guessNumber{
            //Smaller
            Repo.shared.live-=1

        }else{
            //Equel
        }
    }
    
}

//Singleton usage with constant string class.
class ConstTexts{
    private init() {}
    static let shared:ConstTexts = ConstTexts()
    let liveAndYourGuess:String = "Live and Your Guess"
    let inValidValue:String = "InValid Value"
    let saved:String = "Saved"
    let saveNumberToStartGame = "Please save any number to start the game."
}

// Singleton Usage Repo class.
class Repo{
    private init() {}
    static let shared = Repo()
    var live:Int = 5
    var guessNumber:Int = 0
}

enum CallImages{case arrowDown,arrowUp}
//
//extension CallImages {
//    var call:UIImage {get {
//        switch name {
//        case CallImages.arrowDown:
//            return UIImage(named: self.name)
//        case CallImages.arrowUp:
//            return UIImage(named: self.name)
//        default:
//            return UIImage(named: "arrowDown")
//        }
//    }}
//}

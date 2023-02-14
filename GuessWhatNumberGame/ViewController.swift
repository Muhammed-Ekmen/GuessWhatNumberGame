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
            guessNumberFieldSituation()
        }else{
            userNumberOnErrorText.text = ConstTexts.shared.inValidValue
        }
    }
    
    @IBAction func tryButtonAction(_ sender: UIButton) {
        //firstly, you should check the text type.
        if let guessNumber = Int(guessNumberTextField.text!){
            if Repo.shared.live > 1 {
                guessNumberProcessing(guessNumber: guessNumber)
            }else{
                resetGame()
            }
        }
    }
    
    
    @IBAction func howIsItPlayAction(_ sender: UIButton) {
        howIsPlayAlert()
    }
    
    
    
    
    //Required structures.
    func resetGame(){
        infoText.text = ConstTexts.shared.gameOver
        liveText.text?.removeAll()
        guessImage.isHidden = true
        guessNumberOnErrorText.text = ConstTexts.shared.inValidValue
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
            Repo.shared.live = 5
            self.userNumberTextField.text?.removeAll()
            self.userNumberOnErrorText.text?.removeAll()
            self.guessNumberTextField.text?.removeAll()
            self.userNumberFieldSituation()
            self.getReady()
        }
    }
    
    func getReady(){
        userNumberOnErrorText.text?.removeAll()
        guessNumberOnErrorText.text?.removeAll()
        guessNumberFieldSituation()
        guessImage.isHidden = true
        liveText.text?.removeAll()
        userNumberTextField.isSecureTextEntry = true
        infoText.text = ConstTexts.shared.saveNumberToStartGame
    }
    
    
    func userNumberFieldSituation(){
        userNumberTextField.isEnabled = !userNumberTextField.isEnabled
        saveButton.isEnabled = !saveButton.isEnabled
    }
    
    func guessNumberFieldSituation(){
        guessNumberTextField.isEnabled = !guessNumberTextField.isEnabled
        tryNumberButton.isEnabled = !tryNumberButton.isEnabled
    }
    
    func guessNumberProcessing(guessNumber:Int){
        if guessNumber == Repo.shared.guessNumber {
            //Equel Situation
            restartAlert()
        }else{
            Repo.shared.live-=1
            liveText.text = String(Repo.shared.live)
            if guessImage.isHidden == true {
                guessImage.isHidden = false
            }
            if guessNumber > Repo.shared.guessNumber {
                // Bigger
                guessImage.image = CallImages.arrowDown.apply
            }else if guessNumber < Repo.shared.guessNumber{
                //Smaller
                guessImage.image = CallImages.arrowUp.apply
            }
            guessNumberTextField.text?.removeAll()
        }
    }
    
    func restartAlert(){
        let alertCtrl = UIAlertController(title: ConstTexts.shared.gameMessage, message: ConstTexts.shared.winMessage, preferredStyle: UIAlertController.Style.alert)
        let restartAction = UIAlertAction(title: ConstTexts.shared.restart, style: UIAlertAction.Style.default) {
            (action:UIAlertAction) in
            self.resetGame()
        }
        alertCtrl.addAction(restartAction)
        present(alertCtrl, animated: true,completion: nil)
        return
    }
    
    func howIsPlayAlert(){
        let alertCtrl = UIAlertController(title: ConstTexts.shared.howIsItPlay, message: ConstTexts.shared.gameInstruction, preferredStyle: UIAlertController.Style.alert)
        let IGotIt = UIAlertAction(title: ConstTexts.shared.IgotIt, style: UIAlertAction.Style.default) {
            (action:UIAlertAction) in print(ConstTexts.shared.okey)
        }
        alertCtrl.addAction(IGotIt)
        present(alertCtrl, animated: true,completion: nil)
    }
}

//Singleton usage with constant string class.
class ConstTexts{
    private init() {}
    static let shared:ConstTexts = ConstTexts()
    
    let liveAndYourGuess:String = "Live and Your Guess"
    let inValidValue:String = "InValid Value"
    let saved:String = "Saved"
    let saveNumberToStartGame:String = "Please save any number to start the game."
    let gameOver:String = "Game Over,game will restart in 3 seconds..."
    let okey = "Okey"
    let restart = "Restart"
    let gameMessage = "--Game Message--"
    let howIsItPlay:String = "How is the game play?"
    let gameInstruction:String = "game will 5 live to user. guess what number entered, find it :)"
    let IgotIt:String = "I Got it."
    let winMessage:String = "YOU WIN. The game will restart automatically."
}

// Singleton Usage Repo class.
class Repo{
    private init() {}
    static let shared = Repo()
    
    var live:Int = 5
    var guessNumber:Int = 0
}


//Image calling with enum and extentions
enum CallImages{case arrowDown,arrowUp}

extension CallImages {
    var apply:UIImage {get {
        switch self {
        case CallImages.arrowDown:
            return UIImage(named: "arrowDown")!
        case CallImages.arrowUp:
            return UIImage(named: "arrowUp")!
            }
        }
    }
}

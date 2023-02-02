import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case nought
        case cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1button: UIButton!
    @IBOutlet weak var a2button: UIButton!
    @IBOutlet weak var a3button: UIButton!
    
    @IBOutlet weak var b1button: UIButton!
    @IBOutlet weak var b2button: UIButton!
    @IBOutlet weak var b3button: UIButton!
    
    @IBOutlet weak var c1button: UIButton!
    @IBOutlet weak var c2button: UIButton!
    @IBOutlet weak var c3button: UIButton!
    
    var firstTurn = Turn.cross
    var currentTurn = Turn.cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    var noughtsScore = 0
    var crossesScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitViews()
    }
     func setInitViews() {
        board.append(a1button)
        board.append(a2button)
        board.append(a3button)
        board.append(b1button)
        board.append(b2button)
        board.append(b3button)
        board.append(c1button)
        board.append(c2button)
        board.append(c3button)
    }


    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            resultAlert(title: "Crosses WIN!")
            crossesScore += 1
        }
        
        if checkForVictory(NOUGHT) {
            resultAlert(title: "Noughts WIN!")
            noughtsScore += 1
        }
        
        if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s: String) -> Bool {
        //Horizontal
        if thisSymbol(a1button, s) && thisSymbol(a2button, s) && thisSymbol(a3button, s) {
            return true
        }
        if thisSymbol(b1button, s) && thisSymbol(b2button, s) && thisSymbol(b3button, s) {
            return true
        }
        if thisSymbol(c1button, s) && thisSymbol(c2button, s) && thisSymbol(c3button, s) {
            return true
        }
        
        //Vertical
        if thisSymbol(a1button, s) && thisSymbol(b1button, s) && thisSymbol(c1button, s) {
            return true
        }
        if thisSymbol(a2button, s) && thisSymbol(b2button, s) && thisSymbol(c2button, s) {
            return true
        }
        if thisSymbol(a3button, s) && thisSymbol(b3button, s) && thisSymbol(c3button, s) {
            return true
        }
        
        //Diagonal
        if thisSymbol(a1button, s) && thisSymbol(b2button, s) && thisSymbol(c3button, s) {
            return true
        }
        if thisSymbol(a3button, s) && thisSymbol(b2button, s) && thisSymbol(c1button, s) {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for:.normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Reset", style: .default,handler: { _ in
            self.resetBoard()
        }))
        self.present(alertController, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.nought {
            firstTurn = Turn.cross
            turnLabel.text = CROSS
        } else if firstTurn == Turn.cross {
            firstTurn = Turn.nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if currentTurn == Turn.nought {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.cross
                turnLabel.text = CROSS
            } else if currentTurn == Turn.cross {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.nought
                turnLabel.text = NOUGHT
            }
        }
    }
}


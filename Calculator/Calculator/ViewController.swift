import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private weak var digit0Button: UIButton!
    @IBOutlet private weak var digit1Button: UIButton!
    @IBOutlet private weak var digit2Button: UIButton!
    @IBOutlet private weak var digit3Button: UIButton!
    @IBOutlet private weak var digit4Button: UIButton!
    @IBOutlet private weak var digit5Button: UIButton!
    @IBOutlet private weak var digit6Button: UIButton!
    @IBOutlet private weak var digit7Button: UIButton!
    @IBOutlet private weak var digit8Button: UIButton!
    @IBOutlet private weak var digit9Button: UIButton!
    @IBOutlet private weak var cleanButton: UIButton!
    @IBOutlet private weak var sumOpButton: UIButton!
    @IBOutlet private weak var subtractOpButton: UIButton!
    @IBOutlet private weak var timesOpButton: UIButton!
    @IBOutlet private weak var divideOpButton: UIButton!
    @IBOutlet private weak var equalButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    
    var firstValue: Int = 0
    var secondValue: Int = 0
    var operation: String = ""

    // MARK: - Stored Properties

    private let calculator = Calculator()

    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTouchEvents()
    }

    // MARK: -

    /// Registra o método que será acionado ao tocar em cada um dos eventos.
    private func registerTouchEvents() {
        let digitButtons = [digit0Button, digit9Button, digit8Button,
                            digit7Button, digit6Button, digit5Button,
                            digit4Button, digit3Button, digit2Button,
                            digit1Button]

        let operationButtons = [sumOpButton, subtractOpButton, timesOpButton, divideOpButton]

        digitButtons.forEach { $0?.addTarget(self, action: #selector(digitTap), for: .touchUpInside) }
        operationButtons.forEach { $0?.addTarget(self, action: #selector(operationTap(sender:)), for: .touchUpInside) }
        cleanButton.addTarget(self, action: #selector(clearTap), for: .touchUpInside)
        equalButton.addTarget(self, action: #selector(makeOperation), for: .touchUpInside)
    }

    /// Esse método é responsável por adicionar um dígito na calculadora
    /// - Parameter sender: Referência do botão que está executando a ação
    @objc func digitTap(sender: UIButton) {
        var label = resultLabel.text ?? ""
        
        if label == "0" {
            label = ""
        }
        
        switch sender {
        case digit0Button:
            label += "0"
        case digit1Button:
            label += "1"
        case digit2Button:
            label += "2"
        case digit3Button:
            label += "3"
        case digit4Button:
            label += "4"
        case digit5Button:
            label += "5"
        case digit6Button:
            label += "6"
        case digit7Button:
            label += "7"
        case digit8Button:
            label += "8"
        case digit9Button:
            label += "9"
        default:
            label = "Err"
        }
        resultLabel.text = label
    }

    /// Método acionado quando o botão AC é tocado.
    @objc func clearTap() {
        self.resultLabel.text = "0"
    }

    /// Metódo responsável por escolhe qual a operação será realizada.
    /// - Parameter sender: Referência do botão de operação que foi tocado
    @objc func operationTap(sender: UIButton) {
        self.firstValue = Int(resultLabel.text ?? "0") ?? 0
        switch sender {
        case subtractOpButton:
            self.operation = "-"
        case timesOpButton:
            self.operation = "*"
        case divideOpButton:
            self.operation = "/"
        default:
            self.operation = "+"
        }
        self.clearTap()
    }

    /// Método acionado quando o botão = é tocado.
    @objc func makeOperation() {
        self.secondValue = Int(resultLabel.text ?? "0") ?? 0
        switch self.operation {
        case "-":
            self.resultLabel.text = String(self.firstValue - self.secondValue)
        case "*":
            self.resultLabel.text = String(self.firstValue * self.secondValue)
        case "/":
            self.resultLabel.text = String(self.firstValue / self.secondValue)
        default:
            self.resultLabel.text = String(self.firstValue + self.secondValue)
        }
    }
}

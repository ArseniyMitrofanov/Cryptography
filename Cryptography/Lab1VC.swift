//
//  Lab1VC.swift
//  Cryptography
//Vigenere
//  Created by Арсений on 10.02.23.
//decimation

import UIKit

class Lab1VC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    let background: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let urlInput = URL(filePath: "/Users/arsenij/Documents/input.txt")
    let urlOutput = URL(filePath: "/Users/arsenij/Documents/output.txt")
    let alphabet: [Character] = ["А","Б","В","Г","Д","Е","Ё","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я",]
    let pickerData1: [String] = ["шифрование","дешифрование","Виженер","децимации"]
    var isEncryption = true
    var isVigenere = true
    var key: String = ""
    let pickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let keyTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ключ"
        return textField
    }()
    let keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    let tryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Try", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.isEnabled = false
        button.isHidden = true
        return button
    }()
    let textView:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.font = .systemFont(ofSize: 20)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .white
        view.alpha = 0.7
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        readFile()
        tryButton.addTarget(self, action: #selector(tryTapped), for: .touchUpInside)
        pickerView.delegate = self
        pickerView.dataSource = self
        keyTextField.delegate = self
    }
    func makeLayout(){
        background.frame = self.view.frame
        self.view.addSubview(background)
        self.view.addSubview(keyLabel)
        self.view.addSubview(keyTextField)
        self.view.addSubview(pickerView)
        self.view.addSubview(tryButton)
        self.view.addSubview(textView)
        NSLayoutConstraint.activate([
            keyTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            keyTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            keyTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            keyLabel.topAnchor.constraint(equalTo: keyTextField.bottomAnchor, constant: 5),
            keyLabel.leadingAnchor.constraint(equalTo: keyTextField.leadingAnchor),
            keyLabel.trailingAnchor.constraint(equalTo: keyTextField.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: keyTextField.bottomAnchor,constant: 25),
            pickerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            pickerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -0),
            pickerView.heightAnchor.constraint(equalToConstant: 150),
            tryButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: -25),
            tryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tryButton.widthAnchor.constraint(equalToConstant: 100),
            textView.topAnchor.constraint(equalTo: tryButton.bottomAnchor, constant: 15),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            
            
        ])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.key = textField.text?.uppercased() ?? ""
        textField.text = self.key
        keyLabel.text = self.key
        if key != ""{
            tryButton.isEnabled = true
            tryButton.isHidden = false
        }else{
            tryButton.isEnabled = false
            tryButton.isHidden = true
        }
        self.view.endEditing(true)
        return true
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            if row == 0 {
                isEncryption = true
            }else{
                isEncryption = false
            }
        }else{
            if row == 0 {
                isVigenere = true
            }else{
                isVigenere = false
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return pickerData1[row]
        }else{
            return pickerData1[row + 2]
        }
    }
    func readFile()-> String{
        var string = ""
        do{
            string = try String(contentsOf: urlInput, encoding: .utf8)
        } catch{
            print("read Error")
        }
        return string
    }
    func writeFile(string: String){
        do{
            try string.write(to: urlOutput, atomically: true, encoding: String.Encoding.utf8)
        } catch{
            print("Error")
        }
        textView.text = string
    }
    func encryptVigenere(plaintext: String){
        var ciphertext = ""
        var keyIndex = 0
        for symbol in plaintext {
            let keyCharacter: Character = key[key.index(key.startIndex, offsetBy: keyIndex)]
            if alphabet.contains(keyCharacter){
                if alphabet.contains(symbol){
                    ciphertext.append(alphabet[(alphabet.firstIndex(of: symbol)! + alphabet.firstIndex(of: keyCharacter)!)%alphabet.count])
                    keyIndex += 1
                    if (keyIndex)==key.count{
                        keyIndex = 0
                    }
                }else{
                    ciphertext.append(symbol)
                }
            }else{
                showKeyAllert()
            }
        }
        writeFile(string: ciphertext)
    }
    func decryptVigenere(ciphertext: String){
        var plaintext = ""
        var keyIndex = 0
        for symbol in ciphertext {
            let keyCharacter: Character = key[key.index(key.startIndex, offsetBy: keyIndex)]
            if alphabet.contains(keyCharacter) {
                if alphabet.contains(symbol){
                    plaintext.append(alphabet[(alphabet.firstIndex(of: symbol)! - alphabet.firstIndex(of: keyCharacter)! + alphabet.count)%alphabet.count])
                    keyIndex += 1
                    if (keyIndex)==key.count{
                        keyIndex = 0
                    }
                }else{
                    plaintext.append(symbol)
                }
            }else {
                showKeyAllert()
            }
        }
        writeFile(string: plaintext)
    }
    //АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
    func decimation(text: String){
        var result = ""
        if (Int(self.key) != nil)&&(checkKeys(k: Int(self.key)!, n: 33) == 1){
            let key = Int(self.key)
            for symbol in text {
                if alphabet.contains(symbol){
                    result.append(alphabet[(alphabet.firstIndex(of: symbol)! * key!)%alphabet.count])
                }else{
                    result.append(symbol)
                }
            }
            writeFile(string: result)
        }else{
            showKeyAllert()
        }
    }
    func showKeyAllert(){
        let alert = UIAlertController(title: "Ошибка", message: "Ключ содержит недопустимое значение", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func checkKeys(k: Int, n:  Int)->Int{
        var a = k
        var b = n
        while (a != 0)&&(b != 0) {
            if a > b {
                a %= b
            }else{
                b %= a
            }
        }
        return (a+b)
    }
    @objc func tryTapped(){
        textFieldShouldReturn(keyTextField)
        if isEncryption{
            if isVigenere{
                encryptVigenere(plaintext: readFile().uppercased())
            }else{
                decimation(text: readFile().uppercased())
            }
        }else{
            if isVigenere{
                decryptVigenere(ciphertext: readFile().uppercased())
            }else{
                decimation(text: readFile().uppercased())
            }
        }
    }
}





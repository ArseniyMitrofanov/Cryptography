//
//  Lab1VC.swift
//  Cryptography
//Vigenere
//  Created by Арсений on 10.02.23.
//decimation

import UIKit

class Lab1VC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    let pathWithFileName = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
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
    let tryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Try", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.isEnabled = false
        button.isHidden = true
        return button
    }()
    let textView:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
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
        self.view.addSubview(keyTextField)
        self.view.addSubview(pickerView)
        self.view.addSubview(tryButton)
        self.view.addSubview(textView)
        NSLayoutConstraint.activate([
            keyTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            keyTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            keyTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            pickerView.topAnchor.constraint(equalTo: keyTextField.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            pickerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -0),
            pickerView.heightAnchor.constraint(equalToConstant: 150),
            tryButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor),
            tryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tryButton.widthAnchor.constraint(equalToConstant: 100),
            textView.topAnchor.constraint(equalTo: tryButton.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            
            
        ])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.key = textField.text?.uppercased() ?? ""
        textField.text = self.key
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
        let pathWithFileName = self.pathWithFileName.appendingPathComponent("f.txt")
        do{
            string = try String(contentsOf: pathWithFileName)
        } catch{
            print("Error")
        }
        print("_rrrrrr_")
        print(pathWithFileName.path())
        textView.text = string
        return string
    }
    func writeFile(string: String){
        let pathWithFileName = self.pathWithFileName.appendingPathComponent("f.txt")
        print("_wwwwww_")
        print(pathWithFileName.path())
        do{
            try string.write(to: pathWithFileName, atomically: true, encoding: String.Encoding.utf8)
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
            if alphabet.contains(symbol) && alphabet.contains(keyCharacter){
                ciphertext.append(alphabet[(alphabet.firstIndex(of: symbol)! + alphabet.firstIndex(of: keyCharacter)!)%alphabet.count])
            }else{
                ciphertext.append(symbol)
            }
            keyIndex += 1
            if (keyIndex)==key.count{
                keyIndex = 0
            }
        }
        writeFile(string: ciphertext)
    }
    func decryptVigenere(ciphertext: String){
        var plaintext = ""
        var keyIndex = 0
        for symbol in ciphertext {
            let keyCharacter: Character = key[key.index(key.startIndex, offsetBy: keyIndex)]
            if alphabet.contains(symbol) && alphabet.contains(keyCharacter){
                plaintext.append(alphabet[(alphabet.firstIndex(of: symbol)! - alphabet.firstIndex(of: keyCharacter)! + alphabet.count)%alphabet.count])
            }else{
                plaintext.append(symbol)
            }
            keyIndex += 1
            if (keyIndex)==key.count{
                keyIndex = 0
            }
        }
        writeFile(string: plaintext)
    }
    //АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
    func decimation(text: String){
        var result = ""
        if Int(self.key) != nil{
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
            print("key error")
        }
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





//
//  Lab2VC.swift
//  Cryptography
//
//  Created by Арсений on 1.04.23.
//

import UIKit

class Lab2VC: UIViewController, UITextViewDelegate {
    var stateText = ""
    let background: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let stateTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 10
        textView.font = .systemFont(ofSize: 20)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = .white
        textView.alpha = 0.8
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let okBarButtonItem: UIBarButtonItem = {
            let item = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(okTapped))
            return item
        }()
        navigationItem.setRightBarButton(okBarButtonItem, animated: false)
        makeLayout()
        stateTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    func makeLayout(){
        
        background.frame = self.view.frame
        self.view.addSubview(background)
        self.view.addSubview(stateTextView)
        NSLayoutConstraint.activate([
            stateTextView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stateTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stateTextView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            stateTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    func readBinaryFile(filePath: String) -> [UInt8]? {
        let fileData = FileManager.default.contents(atPath: filePath)
        if let data = fileData {
            let byteArray = [UInt8](data)
            return byteArray
        } else {
            return nil
        }
    }
    
    func writeBinaryFile(data: [UInt8], filePath: String) -> Bool {
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            try Data(bytes: data).write(to: fileURL)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func generateLFSRKey(initialState: String) -> [UInt8] {
        var state = Array(initialState.filter { "01".contains($0) }.prefix(28)).map { UInt8(String($0))! }
        var key = [UInt8]()
        
        for _ in 0..<state.count {
            let xorResult = state[0] ^ state[1] ^ state[2] ^ state[3] ^ state[6] ^ state[7] ^ state[8] ^ state[12] ^ state[16] ^ state[19] ^ state[20] ^ state[22] ^ state[23] ^ state[24] ^ state[25] ^ state[26]
            key.append(state[0])
            state.removeFirst()
            state.append(xorResult)
        }
        
        return key
    }
    
    func applyKey(data: [UInt8], key: [UInt8]) -> [UInt8] {
        var result = [UInt8]()
        
        for i in 0..<data.count {
            result.append(data[i] ^ key[i % key.count])
        }
        
        return result
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        stateText = textView.text
        print(stateText)
    }
    @objc func okTapped(){
        self.view.endEditing(true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

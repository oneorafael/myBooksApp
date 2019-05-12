//
//  AddEditViewController.swift
//  MyBooks
//
//  Created by Rafael Oliveira on 11/05/19.
//  Copyright © 2019 Rafael Oliveira. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfPlatform: UITextField!
    @IBOutlet weak var btAddEdit: UIButton!
    
    var book: Book!
    lazy var pickerView:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
        
    }()
    var platformsManager = PlatformsManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePlatformTextField()
        if book != nil{
            title = "Editar jogo"
            btAddEdit.setTitle("ALTERAR", for: .normal)
            tfTitle.text = book.title
            if let platform = book.platform, let index = platformsManager.platforms.firstIndex(of:platform){
                tfPlatform.text = platform.name
                pickerView.selectRow(index, inComponent: 0, animated: true)
            }
            
        }
        
        
        
    }
    
    func preparePlatformTextField(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel,btFlexibleSpace,btDone]
        tfPlatform.inputView = pickerView
        tfPlatform.inputAccessoryView = toolbar
        
    }
    
    @objc func cancel(){
        tfPlatform.resignFirstResponder()
        
    }
    @objc func done(){
        tfPlatform.text = platformsManager.platforms[pickerView.selectedRow(inComponent: 0)].name
        cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        platformsManager.loadPlatforms(with: context)
    }
    
    // MARK: - save button
    @IBAction func btAddEdit(_ sender: UIButton) {
        if book == nil {
            book = Book(context: context)
        }
        book.title = tfTitle.text
        if tfPlatform.text!.isEmpty {
            let platform = platformsManager.platforms[pickerView.selectedRow(inComponent: 0)]
            book.platform = platform
        }
        
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
        navigationController?.popViewController(animated: true)
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
extension AddEditViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return platformsManager.platforms.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let platform = platformsManager.platforms[row]
        return platform.name
    }
}

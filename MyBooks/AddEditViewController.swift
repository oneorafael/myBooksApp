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
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    // MARK: - save button
    @IBAction func btAddEdit(_ sender: UIButton) {
        if book == nil {
            book = Book(context: context)
        }
        book.title = tfTitle.text
        
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


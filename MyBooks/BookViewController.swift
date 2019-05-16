//
//  BookViewController.swift
//  MyBooks
//
//  Created by Rafael Oliveira on 11/05/19.
//  Copyright © 2019 Rafael Oliveira. All rights reserved.
//
import UIKit
import Cosmos

class BookViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPlatform: UILabel!
    @IBOutlet weak var CosmosView: CosmosView!
    var book: Book!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .black
        CosmosView.settings.updateOnTouch = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbTitle.text = book.title
        lbPlatform.text = book.platform?.name
        CosmosView.rating = book.rating
        
        CosmosView.didFinishTouchingCosmos = { rating in
            print(rating)
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.book = book
    }
    
    
    
    
}

//
//  BooksTableViewController.swift
//  MyBooks
//
//  Created by Rafael Oliveira on 11/05/19.
//  Copyright © 2019 Rafael Oliveira. All rights reserved.
//

import UIKit
import CoreData

class BooksTableViewController: UITableViewController {
    var FetchedResultsController: NSFetchedResultsController<Book>!
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Não há livros cadastrados"
        label.textAlignment = .center
        loadBooks()
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    func loadBooks(){
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        FetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        FetchedResultsController.delegate = self
        do {
            try FetchedResultsController.performFetch()
        } catch  {
            print(error.localizedDescription)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "bookSegue" {
            let vc = segue.destination as! BookViewController
            if let books = FetchedResultsController.fetchedObjects {
                vc.book = books[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = FetchedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BooksTableViewCell
        
        guard let book = FetchedResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.prepare(with: book)
        return cell
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let book = FetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            context.delete(book)
        }
    }
}
extension BooksTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            tableView.reloadData()
        }
    }
}

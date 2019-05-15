//
//  PlatformsTableViewController.swift
//  MyBooks
//
//  Created by Rafael Oliveira on 12/05/19.
//  Copyright © 2019 Rafael Oliveira. All rights reserved.
//

import UIKit

class PlatformsTableViewController: UITableViewController {
    
    var platformsManager = PlatformsManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlatforms()
    }
        // MARK: - load platforms
    func loadPlatforms(){
        platformsManager.loadPlatforms(with: context)
        tableView.reloadData()
    }
    
        // MARK: - btn add platform
    @IBAction func addPlatform(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
        // MARK: - show popup to add or edit platform
    func showAlert(with platform: Platform?){
        
        let title = platform == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nome da plataforma"
            if let name = platform?.name {
                textField.text = name
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let platform = platform ?? Platform(context: self.context)
            
            platform.name = alert.textFields?.first?.text
            do{
                try self.context.save()
                self.loadPlatforms()
            } catch {
                print(error.localizedDescription)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
        // MARK: - popup appear when you touch in the cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let platform = platformsManager.platforms[indexPath.row]
        showAlert(with: platform)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return platformsManager.platforms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let platform = platformsManager.platforms[indexPath.row]
        cell.textLabel?.text = platform.name
        return cell
    }
        // MARK: - delete cell with fade
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            platformsManager.deletePlatforms(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

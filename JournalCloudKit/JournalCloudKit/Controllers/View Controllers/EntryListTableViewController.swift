//
//  EntryListTableViewController.swift
//  JournalCloudKit
//
//  Created by Kristin Samuels  on 6/29/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func loadData() {
        EntryController.shared.fetchEntriesWith { (result) in
            switch result {
            case .success(let entries):
                EntryController.shared.entries = entries ?? []
                self.updateViews()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }

    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.dateAsString()

        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            guard let destination = segue.destination as? EntryDetailViewController else { return }
            let entryToSend = EntryController.shared.entries[indexPath.row]
            destination.entry = entryToSend
        }
    }
}

//
//  ViewController.swift
//  UITableViewFiltering
//
//  Created by Leonardo Cardoso on 26.09.18.
//  Copyright © 2018 Leonardo Cardoso • https://leocardz.com. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Properties
    private var source = [
        "environmental", "grandmother", "sit", "swarm", "automatic", "lace", "distant", "contemporary", "difficulty", "eye", "recognize", "training", "winter", "chance", "braid", "single", "decade", "anniversary", "cathedral", "current", "depart", "oven", "domination", "duty", "president", "expansion", "sensitive", "unanimous", "moment", "organ", "opera", "drown", "source", "cow", "snake", "past", "scandal", "tax", "boom", "revolution", "pierce", "norm", "mosaic", "document", "map", "trust", "bean", "leftovers", "tradition", "conflict", "contain", "lunch", "walk", "greet", "cigarette", "rack", "reward", "chorus", "solution", "mother", "Mars", "related", "plan", "rape", "struggle", "emphasis", "trouble", "illness", "owner", "castle", "curtain", "achievement", "reality", "tell", "volcano", "headquarters", "ice", "fever", "hostility", "spectrum", "network", "unpleasant", "ward", "will", "episode", "cultivate", "find", "lift", "unlikely", "book", "nose", "deport", "update", "work", "opinion", "imperial", "perception", "perceive", "applaud", "breathe"
    ]
    
    private var filtered: [String] = []
    
    private let searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.accessibilityIdentifier = "SearchBar"
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = #colorLiteral(red: 0.8360546875, green: 0.8360546875, blue: 0.8360546875, alpha: 1)
        searchController.searchBar.barStyle = .black
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.returnKeyType = .done
        
        return searchController
        
    }()
    
    
    private var searchText = String()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.isTranslucent = false
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        
        source = source.sorted(by: { $0.lowercased() < $1.lowercased() })
        filtered = source
        
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return filtered.count }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        
        cell.textLabel?.text = filtered[indexPath.row]
        
        return cell
        
    }
    
}

/// UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText.lowercased()
        let filtered = source.filter({ $0.lowercased().contains(searchText) })
        self.filtered = filtered.isEmpty ? source : filtered
        tableView.reloadData()
        
    }
    
}

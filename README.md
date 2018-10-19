# UITableView Filtering

Not a library! *So you don’t have to increase your build time with an extra pod*.

## Concept

In this concept we have two arrays. One of them is the **source** and the other is the **filtered** array. 

Our source will always be the **original untouched array**, because it’s from there that we will filter out the items that match the search text by our searching rules. So a **new** search = a **new** filtering (from the original array to the filtered array).

So you might’ve noticed that the user will never be interact with the original array, but the filtered array.

So for whatever it is, you have to use the filtered array as parameter, for instance:

```swift
// MARK: - UITableViewDataSource
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
	return filtered.count 
}

// MARK: - UITableViewDelegate
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
	guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }

	cell.textLabel?.text = filtered[indexPath.row]
        	
	return cell
        
}
```

## Searching Rule

An important thing to define is the **Searching Rule**. With it, we can pick our items from the original array. You can actually do whatever you want here, say you want only the items that start with your search, or end with it, or contain it, or even words that have the same length as your search; it is up to you. In my case, I’m using a “string contains” approach.

```swift
/// UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText.lowercased()
        let filtered = source.filter({ $0.lowercased().contains(searchText) }) // <<<
        self.filtered = filtered.isEmpty ? source : filtered
        tableView.reloadData()
        
    }
    
}
```

This will produce something like this:

![][image-1]

If you want to know how to highlight your search, please check my [UILabel Search Highlighter][1].

## License

None. Remember: this is not a lib

[1]:	https://github.com/LeonardoCardoso/UILabelSearchHighlighter

[image-1]:	Assets/Example.gif
//
//  movieTableViewCell.swift
//  FavMovies
//
//  Created by Mac on 31.08.2022.
//

import UIKit

class movieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

// MARK: - MovieController extensions

extension MovieController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie") as! movieTableViewCell
        cell.movieNameLabel.text = movies[indexPath.row]
        return cell
    }
}

extension MovieController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            movies.remove(at: indexPath.row)
            UserDefaults.standard.set(movies, forKey: "ingridients")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

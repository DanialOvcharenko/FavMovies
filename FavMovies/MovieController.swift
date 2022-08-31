//
//  ViewController.swift
//  FavMovies
//
//  Created by Mac on 31.08.2022.
//

import UIKit

class MovieController: UIViewController {
    
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var movie = ""
    var movieTitle = ""
    var movieYear = ""
    var movies = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.object(forKey: "movies") as? [String] {
            movies = data
        }
        tableView.reloadData()
        
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        addingMovie()
        
    }
    
    @IBAction func ClearArrButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you shure" , message: "Really want to clear movie-list?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "yes", style: .default) { [self] (alert) in
            self.movies.removeAll()
            UserDefaults.standard.set(self.movies, forKey: "movies")
            print(self.movies)
            self.tableView.reloadData()
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Private functions
    
    private func addingMovie() {
        
        guard let str = titleTextfield.text else { return }
        guard let year = yearTextfield.text else { return }
        var checkString = true
        var checkInt = true
        let unsuitableForString = "1234567890"
        let unsuitableForInt = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        var isAdded = false
        
        for element in str {
            if unsuitableForString.contains(element) {
                checkString = false
            }
        }
        
        for element in year {
            if unsuitableForInt.contains(element) {
                checkInt = false
            }
        }
        
        if titleTextfield.text == "" || titleTextfield.text?.first == " " || titleTextfield.text?.last == " " || checkString == false || yearTextfield.text == "" || yearTextfield.text?.first == " " || yearTextfield.text?.last == " " || checkInt == false {
                
            let alert = UIAlertController(title: "Attention" , message: "Something wrong, try not to use digits at 'Title field' or field is empty and  try not to use letters at 'Year field' or field is empty", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
                
            if titleTextfield.text == "" || titleTextfield.text?.first == " " || titleTextfield.text?.last == " " || checkString == false {
                titleTextfield.text = ""
            }
            if yearTextfield.text == "" || yearTextfield.text?.first == " " || yearTextfield.text?.last == " " || checkInt == false {
                yearTextfield.text = ""
            }
        } else {
            
            movieTitle = titleTextfield.text ?? "error"
            movie += movieTitle
            titleTextfield.text = ""
            
            movieYear = yearTextfield.text ?? "error"
            movie += " "
            movie += movieYear
            yearTextfield.text = ""
            
            for element in movies {
                if element == movie {
                    isAdded = true
                    break
                } else {
                    isAdded = false
                }
            }
            
            if isAdded == true {
                let alert = UIAlertController(title: "Attention" , message: "this movie has already been added", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                movies.append(movie)
                UserDefaults.standard.set(movies, forKey: "movies")
                displayAlert(message: "You add '\(movie)'")
            }
        
            tableView.reloadData()
            
            movie = ""
        }
        
    }
    
    private func displayAlert(message: String) {
        let alert = UIAlertController(title: "Cool",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
    }

}



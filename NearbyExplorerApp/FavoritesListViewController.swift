//
//  FavoritesListViewController.swift
//  NearbyExplorerApp
//
//  Created by Tringa on 2/28/24.
//

import UIKit

class FavoritesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up your UI and table view
                tableView.dataSource = self
                tableView.delegate = self
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
            }

            // MARK: - UITableViewDataSource

            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return FavoritesModel.favorites.count
            }

            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
                let favoritePlace = FavoritesModel.favorites[indexPath.row]

                cell.textLabel?.text = favoritePlace.name
                // You can add other details as needed, such as address, phone, etc.

                return cell
            }

            // MARK: - UITableViewDelegate

            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                // Implement the action when a favorite is selected, if needed
                let selectedFavorite = FavoritesModel.favorites[indexPath.row]
                print("Selected Favorite: \(selectedFavorite.name)")
            }

            // You can implement other UITableViewDelegate methods as needed

        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



//
//  FavoriteModel.swift
//  NearbyExplorerApp
//
//  Created by Tringa on 2/28/24.
//

import Foundation
class FavoritesModel {
    static var favorites: [FavoritePlace] = []

    static func addFavorite(_ place: FavoritePlace) {
        favorites.append(place)
    }

    static func removeFavorite(at index: Int) {
        favorites.remove(at: index)
    }
}

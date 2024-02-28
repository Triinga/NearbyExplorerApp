//
//  FavoritePlace.swift
//  NearbyExplorerApp
//
//  Created by Tringa on 2/28/24.
//

import Foundation
struct FavoritePlace {
    var name: String
    var address: String
    var phone: String

    init(place: PlaceAnnotation) {
        self.name = place.name
        self.address = place.address
        self.phone = place.phone
    }
}


//
//  PlaceDetailViewController.swift
//  NearbyExplorerApp
//
//  Created by Lediona Kadiri on 24.2.24.
//
import Foundation
import UIKit

protocol PlaceDetailViewControllerDelegate: AnyObject {
    func didTapSaveToFavorites()
}

class PlaceDetailViewController: UIViewController {
    let place: PlaceAnnotation
    weak var delegate: PlaceDetailViewControllerDelegate?
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()

    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.alpha = 0.4
        return label
    }()

    var directionsButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Directions", for: .normal)
        return button
    }()

   

    var saveToFavoritesButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save to Favorites", for: .normal)
        return button
    }()

    init(place: PlaceAnnotation) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func directionsButtonTapped(_ sender: UIButton) {
        let coordinate = place.location.coordinate
        guard let url = URL(string: "https://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)") else {
            return
        }
        UIApplication.shared.open(url)
    }

    @objc func saveToFavoritesButtonTapped(_ sender: UIButton) {
           place.isSelected.toggle()

           UserDefaults.standard.set(place.isSelected, forKey: place.id.uuidString)

           if place.isSelected {
               let favoritePlace = FavoritePlace(place: place)
               FavoritesModel.addFavorite(favoritePlace)
           } else {
               if let index = FavoritesModel.favorites.firstIndex(where: { $0.name == place.name }) {
                   FavoritesModel.removeFavorite(at: index)
               }
           }

           // Notify the delegate when "Save to Favorites" is tapped
           delegate?.didTapSaveToFavorites()
       }




    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        nameLabel.text = place.name
        addressLabel.text = place.address

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(addressLabel)

        nameLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true

        let contactStackView = UIStackView()
        contactStackView.translatesAutoresizingMaskIntoConstraints = false
        contactStackView.axis = .vertical  // Change here to vertical
        contactStackView.spacing = UIStackView.spacingUseSystem

        directionsButton.addTarget(self, action: #selector(directionsButtonTapped), for: .touchUpInside)
       
        saveToFavoritesButton.addTarget(self, action: #selector(saveToFavoritesButtonTapped(_:)), for: .touchUpInside)

        contactStackView.addArrangedSubview(directionsButton)
      
        contactStackView.addArrangedSubview(saveToFavoritesButton)

        stackView.addArrangedSubview(contactStackView)

        view.addSubview(stackView)
    }
}

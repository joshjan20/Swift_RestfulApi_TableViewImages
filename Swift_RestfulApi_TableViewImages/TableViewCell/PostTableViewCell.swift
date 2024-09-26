//
//  PostTableViewCell.swift
//  Swift_RestfulApi_TableViewImages
//
//  Created by JJ on 26/09/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Add image view and label to the content view
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        
        // Set constraints for image and label
        NSLayoutConstraint.activate([
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postImageView.widthAnchor.constraint(equalToConstant: 80),
            postImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // Function to load image asynchronously
    func configure(with post: Post) {
        titleLabel.text = post.title
        
        if let url = URL(string: post.thumbnailUrl) {
            // Load image asynchronously
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.postImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}


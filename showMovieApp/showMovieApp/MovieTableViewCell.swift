//
//  MovieTableViewCell.swift
//  showMovieApp
//
//  Created by Nikolay T on 31.01.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filmShortImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setConstraint() {
        self.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        self.addSubview(filmShortImage)
        
        NSLayoutConstraint.activate([
            self.filmShortImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.filmShortImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.filmShortImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.filmShortImage.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -10)
        ])
    }
}

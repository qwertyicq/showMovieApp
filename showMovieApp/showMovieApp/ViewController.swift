//
//  ViewController.swift
//  showMovieApp
//
//  Created by Nikolay T on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Funny Videos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieTableView: UITableView = {
        let table = UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var filmsArray: [MovieData] = [MovieData]() {
        didSet {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
    }
    
    var videoPresenter: VideoPresenter = VideoPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setConstraint()
        
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
        FillMovieData()
        
        let queue = DispatchQueue.global(qos: .background)
        
        queue.async {
            for index in 0...self.filmsArray.count - 1 {
                var counter: UInt8 = 0
                while !self.filmsArray[index].imageIsLoaded && counter < 10 {
                    guard let img = self.videoPresenter.videoSnapshot(urlString: self.filmsArray[index].filmUrlString) else
                    {
                        counter += 1
                        continue
                    }
                    
                    self.filmsArray[index].filmImage = img
                    self.filmsArray[index].imageIsLoaded = true
                }
            }
        }
    }
}

extension ViewController {
    private func setConstraint () {
        self.view.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1)
        ])
        
        self.view.addSubview(movieTableView)
        
        NSLayoutConstraint.activate([
            self.movieTableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
            self.movieTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.movieTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.movieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
    }
}

extension ViewController {
    private func FillMovieData () {
        self.filmsArray.append(MovieData(filmName: "Aladdin", filmUrlString: "https://ia802609.us.archive.org/23/items/Aladdin_315/Aladdin_512kb.mp4", filmImage: UIImage(named: "v1")!))
        self.filmsArray.append(MovieData(filmName: "Avez Vous", filmUrlString: "https://ia800604.us.archive.org/19/items/Avez-vousDjVu...LePlusPetitZooDuMonde/104_Le_Plus_Petit_Zoo_du_Monde.mp4", filmImage: UIImage(named: "v2")!))
        self.filmsArray.append(MovieData(filmName: "The Kings Trumpet", filmUrlString: "https://ia800705.us.archive.org/28/items/TheSpiritOf43_56/The_Spirit_of__43_512kb.mp4", filmImage: UIImage(named: "v3")!))
        self.filmsArray.append(MovieData(filmName: "Popeye the Sailor Meets Aladdin and His Wonderful Lamp", filmUrlString: "https://ia800703.us.archive.org/30/items/Popeye_the_Sailor_Meets_Aladdin_and_His_Wonderful_Lamp/Popeye_-_Aladdin_and_His_Wonderful_Lamp_512kb.mp4", filmImage: UIImage(named: "v4")!))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MovieTableViewCell
        cell.filmShortImage.image = filmsArray[indexPath.row].filmImage
        cell.titleLabel.text = filmsArray[indexPath.row].filmName
        cell.filmShortImage.image = filmsArray[indexPath.row].filmImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoPresenter.loadPlayer(urlString: self.filmsArray[indexPath.row].filmUrlString)
        
        present(videoPresenter.getPlayerController(), animated: true, completion: nil)
        
        movieTableView.deselectRow(at: indexPath, animated: true)
    }
}


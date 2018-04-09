//
//  MovieListViewController.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 28/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var movieService: MoviesServiceProtocol = MoviesAPI()
    var movies: [Movie] = [] {
        didSet {
            setupDatasource()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //FIXME: Tales - a collection view precisa ser reconfigurada toda vez que a view aparece?
        // não esquecer de chamar `super.viewWillAppear(animated)`
        setupCollectionView()
    }

    func setupCollectionView() {
        let insets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = insets
        layout.itemSize = CGSize(width: 180, height: 220)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.white
    }
    
    func setupDatasource() {
        collectionView.delegate = self
        collectionView.dataSource = self
        //FIXME: Tales - não precisa registrar a cell toda vez que `movies` for alterado, melhor fazer isso no viewDidLoad
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func fetchMovies() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.collectionView.isHidden = true
        movieService.fetchMovies { movies in
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.movies = movies
        }
    }

    //FIXME: Tales - remover código comentado - tenho TOC com código comentado depois de remover mais de 4kloc de
    // comentários em um unico arquivo C num projeto que passei quase 10 anos atras :D
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
//FIXME: Tales - por organização do código/projeto, abstração e facilidade de testes, é melhor separar data souce/delegate
// em tipos próprios. Confirme o projeto cresce, manter o DS/delegate como extensão - ou mesmo parte - da view controller
// gera duplicação de código e dificulta testes
extension MovieListViewController: UICollectionViewDataSource {
    //collectionView(_:numberOfItemsInSection:) and collectionView(_:cellForItemAt:)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCollectionViewCell else {
            //FIXME: Tales - não é um bom tratamento de erro. Se é garantido/esperado que sempre seja desenfileirada uma
            // `MovieColectionViewCell`, um `fatalError("mensagem")` avisa ao dev que esqueceu de registrar a cell esperada
            // https://www.swiftbysundell.com/posts/picking-the-right-way-of-failing-in-swift
            // se olharem o fonte da https://github.com/AliSoftware/Reusable, também conseguem facil adicionar essa
            // funcionalidade numa versão simplificada, sem adicionar o Resuable como dependencia
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        }
        
        let movie = self.movies[indexPath.row]
        cell.setup(movie: movie)
        //FIXME: Tales - remover código comentado 😆
        //if let imageURL = URL(string:movie.posterPath) {
        //    let imageResource = ImageResource(downloadURL: imageURL)
        //    cell.imageView.kf.setImage(with: imageResource)
        //}

        return cell
    }
    
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //FIXME: Tales - se método só é usado para log, melhor adicioanr um symbolic breakpoint.
        // se não conhecerem o conceito, ask me how no slack :D
        print("User tapped on item \(indexPath.row)")
    }
}

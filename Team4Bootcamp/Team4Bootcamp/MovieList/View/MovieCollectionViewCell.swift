//
//  MovieCollectionViewCell.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 02/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    let imageFetchable: ImageFetchable = KFImageFetchable()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = UIViewContentMode.scaleToFill //FIXME: Tales - imagem está distorcendo.
        // Usar `scaleAspectFit` ou `scaleAspectFill` é melhor
        
        //FIXME: Tales - é boa pratica adicionar a linha
        // `view.translatesAutoresizingMaskIntoConstraints = false`
        // Como vocês estão usando constraints via código, isso evita que o sistema de autolayout crie automaticamente
        // constraints faltantes com base no sistema de auto resizing mask - a forma "arcaica" de fazer views se
        // redimensionarem. Sem essa linha, se você esquece de adicionar uma constraint, ele cria automaticamente,
        // mas vai se comportar de maneiras bizarras e não vai saber porque. Se adicionar essa linha, ao executar o app
        // vai dar um warning de constraint faltante/ambigua no console, facilitando corrigir as constraints no
        // desenvolvimento
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        //FIXME: Tales - é boa pratica adicionar a linha
        // `view.translatesAutoresizingMaskIntoConstraints = false`
        // Outro ponto, por organização e performance, é colocar essas configurações de cor, linhas, etc no método
        // `configure()` do seu protocolo `CodeView` - reimplementar aqui
        view.sizeToFit()
        view.textColor = UIColor.primaryColor
        view.numberOfLines = 2
        view.lineBreakMode = .byClipping
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = NSTextAlignment.center
        view.baselineAdjustment = .alignCenters
        return view
    }()
    
    lazy var iconButton: UIButton = {
        let view = UIButton(frame: .zero)
        //FIXME: Tales - é boa pratica adicionar a linha
        // `view.translatesAutoresizingMaskIntoConstraints = false`
        view.setImage(UIImage(icon: .favGray), for: UIControlState.normal)
        view.setImage(UIImage(icon: .favFull), for: UIControlState.selected)
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movie: Movie) {
        textLabel.text = movie.title
        let path = MoviesConstants.Endpoints.moviePoster(movie.posterPath).path
        imageFetchable.fetch(imageURL: path, onImage: imageView) {}
    }
}

extension MovieCollectionViewCell: CodeView {
    
    func buildHierarchy() {
        addSubview(imageView)
        addSubview(iconButton)
        addSubview(textLabel)
        
    }
    
    func buildConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(frame.size.height*3/4)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalTo(self)
        }
        
        iconButton.snp.makeConstraints { make in
            make.height.equalTo(frame.size.height/12)
            make.topMargin.equalTo(imageView.snp.bottom).offset(25)
            make.right.equalTo(imageView.snp.rightMargin)
        }
        
        textLabel.snp.makeConstraints { make in
            make.width.equalTo(frame.size.width*6/8)
            make.right.equalTo(iconButton.snp.left)
            make.centerY.equalTo(iconButton.snp.centerY)
            make.left.equalTo(imageView.snp.leftMargin)
        }
    }
    
    func configure() {
        backgroundColor = UIColor.secondaryColor
    }
}

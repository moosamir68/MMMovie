//
//  MoviesViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

protocol MoviesControllerDelegate:class {
    func userChangePageIndex(pageIndex:Int)
    func userSelectedMovie(movie:Movie)
}

import UIKit

class MoviesViewController: MasterCollectionViewController {

    //MARK:- ui properties
    @IBOutlet weak var pageControll: UIPageControl!
    
    override var items: [Codable]{get{return self.viewModel.movies} set{}}
    
    //MARK:- private properties
    private var viewModel:MoviesViewModel
    private weak var delegate:MoviesControllerDelegate?
    
    //MARK:- init
    init(movies:[Movie], size:CGSize, pageIndex:Int, delegate:MoviesControllerDelegate) {
        self.viewModel = FactoryViewModel.MoviesViewModel(movies: movies, pageIndex: pageIndex)
        super.init(nibName: "MoviesViewController", bundle: nil)
        self.cellSize = size
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- public methods
    func updateContent(movies:[Movie], pageIndex:Int){
        self.viewModel.bindMovies(movies: movies, pageIndex: pageIndex)
        self.collectionView.reloadData()
        self.updateUiContentofPageControll(pageIndex: pageIndex)
    }
    
    //MARK:- init ui
    override func initForceUI() {
        super.initForceUI()
        self.collectionView.register(UINib(nibName: identifireMovieCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: identifireMovieCollectionViewCell)
        self.updateUiContentofPageControll(pageIndex: self.viewModel.getPageIndex())
    }
    
    override func initUI() {
        super.initUI()
    }
    
    //MARK:- collection view methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let errorCell = self.checkAndReturnErrorCell(indexPath: indexPath)
        guard errorCell == nil else {
            return errorCell!
        }
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: identifireMovieCollectionViewCell, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !self.checkIsEmptyDataSource() else{
            return;
        }
        
        let movie = self.viewModel.movies[indexPath.row]
        (cell as! MovieCollectionViewCell).fillData(movie: movie)
    }
    
    override func userDidTapOnItem(select item: Any) {
        self.delegate?.userSelectedMovie(movie: item as! Movie)
    }
    
    //MARK:- scrollview methods
    override func userChangePageIndex(pageIndex: Int) {
        self.viewModel.bindPageIndex(pageIndex: pageIndex)
        self.delegate?.userChangePageIndex(pageIndex: pageIndex)
        self.updatePageControll()
    }
    
    //MARK:- private methods
    private func updateUiContentofPageControll(pageIndex:Int){
        if(self.viewModel.canGoToSpecialPage(index: pageIndex)){
            self.pageControll.numberOfPages = self.viewModel.getCountOfPages()
            self.scrollToSpecialPage(pageIndex: self.viewModel.getPageIndex())
            self.updatePageControll()
        }
    }
    
    private func updatePageControll(){
        self.pageControll.currentPage = self.viewModel.getPageIndex()
    }
    
    private func scrollToSpecialPage(pageIndex:Int){
        let indexPath = IndexPath(row: pageIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

//MARK:- extentions

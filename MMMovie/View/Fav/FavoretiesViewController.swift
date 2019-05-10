//
//  FavoretiesViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class FavoretiesViewController: MasterTableViewController {
    
    override var items: [Codable]{get{return self.viewModel.movies}set{}}
    
    //MARK:- private proeprties
    private var viewModel:FavoretiesViewModel!
    
    //MARK:- init
    init() {
        super.init(nibName: "FavoretiesViewController", bundle: nil)
        self.viewModel = FactoryViewModel.favortiesViewModel(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- init force ui
    override func initForceUI() {
        super.initForceUI()
        self.tableView.register(UINib(nibName: identifireMovieTableViewCell, bundle: nil), forCellReuseIdentifier: identifireMovieTableViewCell)
        self.navigationTitleString = "Favoreties movies"
    }
    
    //MARK:- tableview methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let errorCell = self.checkAndGetErrorCell()
        guard errorCell == nil else {
            errorCell?.fillData(title: self.viewModel.errorDecsription)
            return errorCell!
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifireMovieTableViewCell, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !self.checkIsEmptyData() else {
            return;
        }
        
        let movie = self.viewModel.movies[indexPath.row]
        (cell as! MovieTableViewCell).fillData(movie: movie)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getRowHeight()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return getRowHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !self.checkIsEmptyData() else {
            return;
        }
        
        let movie = self.viewModel.movies[indexPath.row]
        self.showMovieDetailController(movie: movie)
    }
    
    override func userDidTapOnDeleteItem(item: Codable) {
        self.viewModel.userWantToDeleteAItemFromCache(movieId: (item as!Movie).id)
    }
    
    //MARK:- private methods
    private func getRowHeight() ->CGFloat{
        guard self.checkIsEmptyData() else{
            return self.tableView.frame.width * 0.562 + 28.0
        }
        
        return self.tableView.frame.height
    }
    
    private func showMovieDetailController(movie:Movie){
        let movieDetailController = MovieDetailViewController(movie: movie, delegate: self)
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
}

//MARK:- extetions
extension FavoretiesViewController:MovieDetailControllerDelegate{
    func userChangeStatusExistMovieOnChache(movieId: Int) {
        self.viewModel.userChangeStatusExistMovieOnCache(movieId: movieId)
    }
}

extension FavoretiesViewController:FavoretiesViewModelDelegate{
    func sucessGetMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func faildGetMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

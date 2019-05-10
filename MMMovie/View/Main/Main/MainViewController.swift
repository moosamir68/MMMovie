//
//  MainViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class MainViewController: MasterTableViewController {

    //MARK:- ui properties
    private var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 56.0))
    
    //MARK:- items
    override var items: [Codable]{get {return self.viewModel.actors} set{}}
    
    //MARK:- private properties
    private var viewModel:MainViewModel!
    
    //MARK:- init
    init(actors:[Actor]) {
        super.init(nibName: "MainViewController", bundle: nil)
        self.viewModel = FactoryViewModel.MainViewModel(actors: actors, delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- force ui
    override func initForceUI() {
        super.initForceUI()
        
        self.initLazyLoading()
        
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.backgroundColor = UIUtility.navigationBarColor()
        self.searchBar.showsCancelButton = true
        self.tableView.tableHeaderView = self.searchBar
        self.searchBar.change(textFont: UIUtility.normalFontWithPlusSize(), color:.white)
        
        
        self.tableView.register(UINib(nibName: identifireActorTableViewCell, bundle: nil), forCellReuseIdentifier: identifireActorTableViewCell)
        self.navigationTitleString = "MMMovie"
        
        let favButton = UIBarButtonItem(image: #imageLiteral(resourceName: "star"), style: .plain, target: self, action: #selector(MainViewController.userDidTapOnFavButton))
        self.navigationItem.rightBarButtonItem = favButton
    }
    
    override func initUI() {
        super.initUI()
        self.tableView.tableFooterView = nil
        self.tableView.separatorStyle = .none
        self.searchBar.delegate = self
        self.tableView.backgroundColor = UIUtility.navigationBarColor()
    }
    
    //get data
    override func getData() {
        _ = self.viewModel.getActors()
    }
    
    //MARK:- tableview delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let errorCell = self.checkAndGetErrorCell()
        guard errorCell == nil else {
            return errorCell!
        }
        
        let actorCell = self.tableView.dequeueReusableCell(withIdentifier: identifireActorTableViewCell, for: indexPath)
        return actorCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !cell.isKind(of: ErrorTableViewCell.classForCoder()) else{
            (cell as! ErrorTableViewCell).fillData(title: self.viewModel.errorDescription)
            return;
        }
        
        let actorCellViewModel = self.viewModel.getActorCellViewModel(row: indexPath.row)
        (cell as! ActorTableViewCell).fillData(delegate: self, actorCellviewModel: actorCellViewModel)
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getHeightForRow()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getHeightForRow()
    }
    
    override func loadMoreData() {
        let canGetMoreItems = self.viewModel.getActors()
        guard canGetMoreItems else {
            return;
        }
        self.showLazyLoading()
    }
    
    private func getHeightForRow() ->CGFloat{
        guard self.checkIsEmptyData()else{
            //500 is image width for movies
            return self.tableView.frame.width * (281.0 / 500.0) + 64.0
        }
        
        return self.tableView.frame.height
    }
    
    @objc private func userDidTapOnFavButton(){
        let favController = FavoretiesViewController(delegate: self)
        self.navigationController?.pushViewController(favController, animated: true)
    }
}

//extentions
extension MainViewController:MainViewModelDelegate{
    func sucessGetActors() {
        DispatchQueue.main.async {
            self.hideLazyLoading()
            self.tableView.reloadData()
        }
    }
    
    func faildGetActors() {
        DispatchQueue.main.async {
            self.hideLazyLoading()
            self.tableView.reloadData()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.hideLazyLoading()
            self.tableView.reloadData()
        }
    }
}

//mehotds of actor cell view
extension MainViewController:ActorCellDelegate{
    func userDidTapOnActor(actor: Actor) {
        print("user select an actor with name:", actor.name!)
    }
    
    func userDidTapOnMovie(movie: Movie) {
        print("user select a movie with name:", movie.title!)
    }
    
    func getActorCellController(viewModel: ActorCellViewModel) -> ActorCellViewController {
        let itemSize = CGSize(width: self.tableView.frame.width, height: self.getHeightForRow())
        let actorCellController = ActorCellViewController(viewModel: viewModel, size: itemSize, delegate:self)
        self.addChild(actorCellController)
        actorCellController.didMove(toParent: self)
        return actorCellController
    }
}

//MARK:- actor cell controller delegate
extension MainViewController:ActorCellControllerDelegate{
    func showMovieDetail(movie: Movie) {
        let movieDetailController = MovieDetailViewController(movie: movie, delegate: self)
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    func showActorDetail(actor: Actor) {
        let actorDetailController = ActorDetailViewController(actor: actor)
        self.navigationController?.pushViewController(actorDetailController, animated: true)
    }
}

//MARK:- movie detail controller delegate
extension MainViewController:MovieDetailControllerDelegate{
    func userChangeStatusExistMovieOnChache(movieId: Int) {
        let index = self.viewModel.getIndexOfItem(movieId: movieId)
        guard let _ = index else {
            return;
        }
        
        let indexPath = IndexPath(row: index!, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

//MARK:- methods of searchbar
extension MainViewController:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeyboard()
        self.viewModel.userDidTapOnCancelButton(text: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeyboard()
        self.viewModel.userDidTaponSearchButton(text: searchBar.text)
    }
}

//methods of favoreties controller
extension MainViewController:FavoretiesControllerDelegate{
    func userChangeStatusExistFromFavortiesController(movieId: Int) {
        self.userChangeStatusExistMovieOnChache(movieId: movieId)
    }
}

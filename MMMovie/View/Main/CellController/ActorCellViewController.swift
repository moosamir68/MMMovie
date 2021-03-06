//
//  ActorCellViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

protocol ActorCellControllerDelegate:class {
    func showActorDetail(actor:Actor)
    func showMovieDetail(movie:Movie)
}

import UIKit

class ActorCellViewController: MasterViewController {
    
    @IBOutlet weak var actorBoxView: UIView!
    @IBOutlet weak var moviesBoxView: UIView!
    
    //MARK:- private properties
    private var viewModel:ActorCellViewModel
    private weak var delegate:ActorCellControllerDelegate?
    
    private var size:CGSize
    private var moviesCellSize:CGSize{get{return CGSize(width: self.size.width, height: self.size.height - 64)}}

    lazy private var actorViewController:ActorViewController = {return ActorViewController(actor: self.viewModel.getActor(), delegate:self)}()
    lazy private var moviesViewController:MoviesViewController = {return MoviesViewController(movies: self.viewModel.getMovies(), size: self.moviesCellSize, pageIndex:self.viewModel.pageIndexOfMovies, delegate:self)}()
    
    //MARK:- init
    init(viewModel:ActorCellViewModel, size:CGSize, delegate:ActorCellControllerDelegate) {
        self.size = size
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: "ActorCellViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- init ui
    override func initForceUI() {
        super.initForceUI()
        self.addActorController()
        self.addMoviesController()
    }
    
    //MARK:- public methods
    func updateContent(viewModel:ActorCellViewModel){
        self.viewModel = viewModel
        self.actorViewController.updateContent(actor: self.viewModel.getActor())
        self.moviesViewController.updateContent(movies: self.viewModel.getMovies(), pageIndex: viewModel.pageIndexOfMovies)
    }
    
    //MARK:- private methods
    private func addActorController(){
        self.addControllerToParentOnView(controller:self.actorViewController, view:self.actorBoxView)
    }
    
    private func addMoviesController(){
        self.addControllerToParentOnView(controller:self.moviesViewController, view:self.moviesBoxView)
    }
    
    private func addControllerToParentOnView(controller:UIViewController, view:UIView){
        self.addChild(controller)
        self.addSubViewToView(view: view, subView: controller.view)
        controller.didMove(toParent: self)
    }
    
    private func addSubViewToView(view:UIView, subView:UIView){
        view.addSubview(subView)
        subView.addConstaintsToSuperview()
    }
}

//MARK:- extentions
extension ActorCellViewController:MoviesControllerDelegate{
    func userChangePageIndex(pageIndex: Int) {
        self.viewModel.bindPageIndexOfMovies(pageIndex: pageIndex)
    }
    
    func userSelectedMovie(movie: Movie) {
        self.delegate?.showMovieDetail(movie: movie)
    }
}

extension ActorCellViewController:ActorControllerDelegate{
    func userSelectActor(actor: Actor) {
        self.delegate?.showActorDetail(actor: actor)
    }
}

//
//  ActorViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/4/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class ActorDetailViewController: MasterViewController {

    //MARK:- ui properties
    @IBOutlet weak var avatarBoxView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //bio uis
    @IBOutlet weak var bioStackView: UIStackView!
    @IBOutlet weak var bioTitlaLabel: UILabel!
    @IBOutlet weak var bioValueLabel: UILabel!
    
    //place of birhday uis
    @IBOutlet weak var placeOfBirthdayStackView: UIStackView!
    @IBOutlet weak var placeOfBirhdayTitleLabel: UILabel!
    @IBOutlet weak var placeOfBirthdayValueLabel: UILabel!
    
    //birthday stackview
    @IBOutlet weak var birhdayStackView: UIStackView!
    @IBOutlet weak var birthdayTitleLabel: UILabel!
    @IBOutlet weak var birthdayVauleLabel: UILabel!
    
    //deathday uis
    @IBOutlet weak var deathDayStackView: UIStackView!
    @IBOutlet weak var deathDayTitleLabel: UILabel!
    @IBOutlet weak var deatchDayValueLabel: UILabel!
    
    //popularity uis
    @IBOutlet weak var popularityStackView: UIStackView!
    @IBOutlet weak var popularityTitleLabel: UILabel!
    @IBOutlet weak var popularityValueLabel: UILabel!
    
    //department uis
    @IBOutlet weak var departmentStackView: UIStackView!
    @IBOutlet weak var deparmnetTitleLabel: UILabel!
    @IBOutlet weak var departmentValueLabel: UILabel!
    
    //also knows uis
    @IBOutlet weak var alsoKnowsStackView: UIStackView!
    @IBOutlet weak var alsoKnoweTitleLabel: UILabel!
    @IBOutlet weak var alsoKnowValueLabel: UILabel!
    
    //MARK:- private proeprties
    private var viewModel:ActorDetailViewModel!
    
    //MARK:- init
    init(actor:Actor) {
        super.init(nibName: "ActorDetailViewController", bundle: nil)
        self.viewModel = FactoryViewModel.ActorDetailViewModel(actor: actor, delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- init ui
    override func initUI() {
        
        self.navigationTitleString = self.viewModel.getName()
        
        super.initUI()
        
        self.profileImageView.layer.cornerRadius = 56.0
        self.profileImageView.layer.masksToBounds = true
        
        self.bindDataOnView()
    }
    
    //MARK:- get data
    override func getData() {
        self.viewModel.getActorDetail()
    }
    
    //MARK:- private methods
    private func bindDataOnView(){
        self.setProfileImage()
        self.actorNameLabel.text = self.viewModel.getName()
        
        //check for bio
        if(self.viewModel.canShowBioView()){
            self.setShowOrHideView(view: self.bioStackView, hide: false)
            self.bioValueLabel.text = self.viewModel.getBio()
        }else{
            self.setShowOrHideView(view: self.bioStackView, hide: true)
        }
        
        //check for birthday place
        if(self.viewModel.canShowPlaceBirhdayView()){
            self.setShowOrHideView(view: self.placeOfBirthdayStackView, hide: false)
            self.placeOfBirthdayValueLabel.text = self.viewModel.getPlaceOfBirhday()
        }else{
            self.setShowOrHideView(view: self.placeOfBirthdayStackView, hide: true)
        }
        
        if(self.viewModel.canShowBirthdayView()){
            self.setShowOrHideView(view: self.birhdayStackView, hide: false)
            self.birthdayVauleLabel.text = self.viewModel.getBirthday()
        }else{
            self.setShowOrHideView(view: self.birhdayStackView, hide: true)
        }
        
        if(self.viewModel.canShowDeathdayView()){
            self.setShowOrHideView(view: self.deathDayStackView, hide: false)
            self.deatchDayValueLabel.text = self.viewModel.getDeathday()
        }else{
            self.setShowOrHideView(view: self.deathDayStackView, hide: true)
        }
        
        if(self.viewModel.canShowPopularityView()){
            self.setShowOrHideView(view: self.popularityStackView, hide: false)
            self.popularityValueLabel.text = self.viewModel.getPopularity()
        }else{
            self.setShowOrHideView(view: self.popularityStackView, hide: true)
        }
        
        if(self.viewModel.canShowDepartmentView()){
            self.setShowOrHideView(view: self.departmentStackView, hide: false)
            self.departmentValueLabel.text = self.viewModel.getDepartment()
        }else{
            self.setShowOrHideView(view: self.departmentStackView, hide: true)
        }
        
        if(self.viewModel.canShowAlsoKnowView()){
            self.setShowOrHideView(view: self.alsoKnowsStackView, hide: false)
            self.alsoKnowValueLabel.text = self.viewModel.getAlsoKnow()
        }else{
            self.setShowOrHideView(view: self.alsoKnowsStackView, hide: true)
        }
    }
    
    private func setProfileImage(){
        let imagePathString = self.viewModel.getImagePath()
        ImageCacheLoader.sharedInstanse.obtainImageWithPath(imagePath: imagePathString, placeHolder: #imageLiteral(resourceName: "AccountPlaceHolder")) {[weak self] (image, imagePath) in
            self?.profileImageView.image = image
        }
    }
    
    private func setShowOrHideView(view:UIStackView, hide:Bool){
        UIView.animate(withDuration: 0.3, animations: {
            view.isHidden = hide
            for subView in view.subviews{
                subView.alpha = hide == true ? 0 : 1
            }
        }) { (finished) in
            self.view.layoutIfNeeded()
        }
    }
    
    func hideActivityIndicator(){
        self.activityIndicator.stopAnimating()
    }
}

//MARK:- extentions
extension ActorDetailViewController:ViewModelDelegate{
    func sucessGetData() {
        DispatchQueue.main.async {
            print("suceess get actor detail")
            self.hideActivityIndicator()
            self.bindDataOnView()
        }
    }
    
    func faildGetData() {
        print("faild get actor detail")
    }
}

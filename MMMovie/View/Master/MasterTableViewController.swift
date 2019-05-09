//
//  MasterTableViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class MasterTableViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView!
    var lazyloading = UIView(frame: .zero)
    var activityIndicator:UIActivityIndicatorView?
    
    var heightForRow:CGFloat = 0.0
    var heightForErrorRow:CGFloat = 0.0
    var items:[Codable] = [Codable]()
    var canProgramicalyAddTableView:Bool = false
    
    //MARK:- init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        if(nibNameOrNil == nil){
            self.canProgramicalyAddTableView = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- view load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initForceUI(){
        super.initForceUI()
        if(self.canProgramicalyAddTableView){
            self.tableView = UITableView()
            self.boxView.addSubview(self.tableView)
            self.boxView.addConstaintsToSuperview()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK:- initui
    override func initUI() {
        super.initUI()
        
        self.tableView.register(UINib(nibName: identifireErrorTableViewCell, bundle: nil), forCellReuseIdentifier: identifireErrorTableViewCell)
        self.tableView.reloadData()
    }
    
    override func getData() {
        
    }
    
    //MARK:- lazy loading init
    func initLazyLoading(){
        self.boxView.addSubview(self.lazyloading)
        self.lazyloading.frame = CGRect(x: 0, y: self.boxView.frame.size.height, width: self.boxView.frame.size.width, height: 40)
        self.activityIndicator = UIActivityIndicatorView(style: .white)
        self.lazyloading.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.lazyloading.addSubview(self.activityIndicator!)
        self.hideLazyLoading()
    }
    
    func removeLazyLoading(){
        self.lazyloading.removeFromSuperview()
    }
    
    func showLazyLoading(){
        self.activityIndicator?.startAnimating()
        self.lazyloading.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.lazyloading.frame = CGRect(x: 0, y: self.boxView.frame.size.height - 40, width: self.boxView.frame.size.width, height: 40)
        }
    }
    
    func hideLazyLoading(){
        self.activityIndicator?.stopAnimating()
        self.lazyloading.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.lazyloading.frame = CGRect(x: 0, y: self.boxView.frame.size.height, width: self.boxView.frame.size.width, height: 40)
        }
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    //MARK:- refreshData
    func refresh(){
        self.getData()
    }
    
    //MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !self.checkIsEmptyData() else {
            return self.heightForErrorRow
        }
        
        return self.heightForRow
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !self.checkIsEmptyData() else {
            return self.heightForErrorRow
        }
        
        return self.heightForRow
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !self.checkIsEmptyData() else {
            return 1
        }
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(self.checkIsEmptyData()){
            
        }else{
            if(indexPath.row == self.items.count - 2){
                self.loadMoreData()
            }
        }
    }
    
    //MARK:- load more data
    public func loadMoreData(){
        self.getData()
    }
    
    //MARK:- check and get error cell
    func checkAndGetErrorCell() -> ErrorTableViewCell?{
        guard self.checkIsEmptyData() else {
            return nil
        }
        
        let errorCell = self.tableView.dequeueReusableCell(withIdentifier: identifireErrorTableViewCell) as? ErrorTableViewCell
        return errorCell
    }
    
    //MARK:- check is empty
    func checkIsEmptyData() ->Bool{
        guard self.items.count == 0 else {
            return false
        }
        return true
    }
}

//
//  MasterCollectionViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class MasterCollectionViewController: MasterViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var canProgramicalyAddTableView:Bool = false
    var items:[Codable] = [Codable]()
    var cellSize:CGSize = CGSize(width: 0, height: 0)
    var minimumLineSpacing:CGFloat = 0
    var minimumInteritemSpacing:CGFloat = 0
    var scrollDirection:UICollectionView.ScrollDirection = .horizontal
    var canShowErrorCell:Bool = false
    var isPagingEnabled:Bool = true
    var isShowHorizontalIndicator:Bool = false
    var isShowVerticalIndicator:Bool = false
    
    @IBOutlet var collectionView:UICollectionView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        if(nibNameOrNil == nil){
            self.canProgramicalyAddTableView = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- force initui
    override func initForceUI(){
        super.initForceUI()
        if(self.canProgramicalyAddTableView){
            self.collectionView = UICollectionView()
            self.boxView.addSubview(self.collectionView)
            self.boxView.addConstaintsToSuperview()
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //MARK:- initUI
    override func initUI() {
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.allowsSelection = true
        self.collectionView.isPagingEnabled = isPagingEnabled
        self.collectionView.showsHorizontalScrollIndicator = self.isShowHorizontalIndicator
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = self.cellSize
        flowLayout.minimumInteritemSpacing = self.minimumInteritemSpacing
        flowLayout.minimumLineSpacing = self.minimumLineSpacing
        flowLayout.scrollDirection = self.scrollDirection
        flowLayout.invalidateLayout()
        self.collectionView.collectionViewLayout = flowLayout
        
        self.collectionView.register(UINib(nibName: identifireErrorCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: identifireErrorCollectionViewCell)
        
        super.initUI()
    }
    
    override func getData() {
        super.getData()
    }
    
    //MARK:- collectionview delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.checkIsEmptyDataSource()){
            if(self.canShowErrorCell){
                return 1
            }
            return 0
        }
        print("count = ", self.items.count)
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(!self.checkIsEmptyDataSource()){
            let item = self.items[indexPath.row]
            self.userDidTapOnItem(select: item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(self.checkIsEmptyDataSource()){
            return CGSize(width: self.boxView.frame.size.width, height: self.boxView.frame.height)
        }
        
        return self.cellSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == self.items.count - 2){
            self.loadMore()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //MARK:- load more
    public func loadMore(){
        
    }
    
    public func showLoadMore(){
        
    }
    
    public func hideLoadMore(){
        
    }
    
    func userChangePageIndex(pageIndex:Int){
        
    }
    //MARK:- internal method
    public func userDidTapOnItem(select item:Any){
        
    }
    
    //MARK:- check is empty data source
    func checkIsEmptyDataSource() -> Bool{
        if(self.items.count == 0){
            return true
        }
        return false
    }
    
    public func checkAndReturnErrorCell(indexPath:IndexPath) ->ErrorCollectionViewCell?{
        if(self.checkIsEmptyDataSource()){
            let errorCell:ErrorCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: identifireErrorCollectionViewCell, for: indexPath) as! ErrorCollectionViewCell
            return errorCell
        }
        return nil
    }
    
    //MARK:- scrollview methods
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPageIndex = Int(scrollView.contentOffset.x / self.collectionView.frame.width)
        self.userChangePageIndex(pageIndex: currentPageIndex)
    }
}


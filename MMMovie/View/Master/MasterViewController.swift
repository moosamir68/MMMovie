//
//  MasterViewController.swift
//  Mealsy
//
//  Created by iOS Developer on 1/13/19.
//  Copyright © 2019 Mealsy. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet var boxView:UIView!
    @IBOutlet weak var stackView:UIStackView!
    var navigationTitleString:String? = nil
    var navigationTitleImage:UIImage? = nil
    
    var automaticalyCallInitsMethod:Bool = true
    var canProgramicalyAddBoxView:Bool = false
    
    var navigationTitleFontSizeIncrease:CGFloat = 6
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        if(nibNameOrNil == nil){
            self.canProgramicalyAddBoxView = true
        }
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("MasterViewController deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initForceUI()
        
        if(self.automaticalyCallInitsMethod){
            self.initUI()
            self.getData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- reload data
    func reloadData(){
        
    }
    
    //MARK:- init
    //this mwthod force for init
    func initForceUI(){
        if(self.canProgramicalyAddBoxView){
            self.boxView = UIView()
            self.view.addSubview(self.boxView)
        }
    }
    
    //MARK:- initui
    func initUI(){
        
        self.edgesForExtendedLayout = []
        
        //navigationbar item color
        self.navigationController?.navigationBar.tintColor = .white
        
        //navigationbar text item color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIUtility.boldFontWithPlusSize(increaseSize: self.navigationTitleFontSizeIncrease), NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        //line under of navigationbar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //navigationbar background color
        self.navigationController?.navigationBar.barTintColor = UIUtility.navigationBarColor()
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back") .withRenderingMode(.alwaysTemplate)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        //set navigation title label
        if(self.navigationTitleString != nil){
            self.setNavigationTitle()
        }else{
            
        }
    }
    
    //set navigaiotn title
    public func setNavigationTitle(){
        self.navigationItem.title = self.navigationTitleString
    }
    
    public func  setNavigationtitleAttribute(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIUtility.boldFontWithPlusSize(increaseSize: self.navigationTitleFontSizeIncrease), NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    //MARK:- get data
    func getData(){
        
    }
}

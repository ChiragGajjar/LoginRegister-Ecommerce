//
//  HomeVC.swift
//  LoginRegister
//
//  Created by Theappfathers on 13/04/21.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import ObjectMapper

class HomeVC: UIViewController {
    
    @IBOutlet weak var collProducts: UICollectionView!
    
    var arrProductData = [ProductDataListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collProducts.register(UINib.init(nibName: ProductCell.userIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.userIdentifier)

        
        GetHomeDetails()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if let flowLayout = self.collProducts.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            self.collProducts.reloadData()
        }
        self.collProducts.reloadData()
        
    }
    
    //MARK:- API WEBSERVICES
    func GetHomeDetails()
    {
        ShowProgress()
        
        let url = createUrlForWebservice(url: APIManager.GET_HOME_DATA)
        print(url)
        
        AFWrapper.servicecallWithHeader(url: url, Method: .get, Parameter: [:]) { (result, IsSuccess) in
            print(result as Any)
            if IsSuccess == true
            {
                HideProgress()
                
                let mapData  = Mapper<ProductDataListModel>().mapArray(JSONString: result ?? "")
                
                if mapData?.count != 0{
                    print("success")
                    self.arrProductData = mapData ?? []
                    
                    self.collProducts.reloadData()
                }else{
                    self.arrProductData = []
                    self.collProducts.reloadData()
                    
                    AlertView.showOKTitleMessageAlert(AlertTitle.Information, strMessage: AlertMessages.kmsgServerError, viewcontroller: self)
                }
            }else{
                HideProgress()
            }
        }
    }
    
}
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {   return arrProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.userIdentifier, for: indexPath) as! ProductCell
        
        let objData = arrProductData[indexPath.row]
        cell.lblName.text = objData.title ?? ""
        cell.lblPrice.text = "$ \(objData.price ?? 0)"
        
        let strImgbannerUrl = "\(objData.image ?? "")"
        cell.imgProduct.setShowActivityIndicator(true)
        cell.imgProduct.setIndicatorStyle(.medium)
        cell.imgProduct.sd_setImage(with: URL.init(string: strImgbannerUrl), placeholderImage: UIImage(named: "App-Default"), completed: { (image, error, cacheType, imageURL) in
        })
        
        
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(btnFavouriteAction(_:)), for: .touchUpInside)
        
        return cell
        
    }
    
    @IBAction func btnFavouriteAction(_ sender: UIButton) {
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collProducts.frame.size.width - 15) / 2.0
        let height = width * 1.2 //ratio
        return CGSize(width: width, height: height)
        
    }
}

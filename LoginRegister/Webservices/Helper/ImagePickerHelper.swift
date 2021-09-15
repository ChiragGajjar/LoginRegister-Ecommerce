//
//  ImagePickerHelper.swift
//  eCommerce Seller
//
//  Created by Theappfathers on 30/04/20.
//  Copyright © 2020 Theappfathers. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import Photos

typealias MediaPickerHelperCallback<inputType> = ((inputType?) -> Void)

class MediaPickerHelper: NSObject {
    
    var controller:UIViewController!
    var callbackForImage: MediaPickerHelperCallback<UIImage>?
    var callbackForVideo: MediaPickerHelperCallback<NSURL>?
    var isForVideo : Bool
    
    
    var titleForActionSheet : String?
    var titleForCameraButton : String?
    var titleForPhotosButton : String?
    
    init(viewController:UIViewController ,isForVideo : Bool, imageCallback: MediaPickerHelperCallback<UIImage>?, videoCallback: MediaPickerHelperCallback<NSURL>?) {
        
        self.controller = viewController
        
        self.callbackForVideo = videoCallback
        self.callbackForImage = imageCallback
        self.isForVideo = isForVideo
        super.init()
    }
    
    func showPhotoSourceSelection() {
        let actionSheet = UIAlertController(title: nil, message:self.titleForActionSheet ?? (self.isForVideo ? "Take Video" :"Take image"), preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cancelAction)
        
        if (UIImagePickerController.isCameraDeviceAvailable(.rear) ) {
            let cameraAction = UIAlertAction(title: self.titleForCameraButton
                ?? "Camera", style: .default, handler: { (action) -> Void in
                    self.checkCameraAccess()
            })
            
            actionSheet.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: self.titleForPhotosButton ?? "Photos", style: .default) { (action) -> Void in
            self.checkLibraryUsagePermission()
        }
        
        actionSheet.addAction(photoLibraryAction)
        
        self.controller.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            imagePickerController.mediaTypes = self.isForVideo ?  [kUTTypeMovie as String] : [kUTTypeImage as String]
            self.controller.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK:- Camera and photo library access check
    func checkLibraryUsagePermission()
    {
//        var accessGranted = false
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized)
        {
            // Access has been granted.
//            accessGranted = true
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        else if (status == PHAuthorizationStatus.denied)
        {
//            accessGranted = false
            self.presentLibraryUsageSettings()
        }
        else if (status == PHAuthorizationStatus.notDetermined)
        {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
//                    accessGranted = true
                    self.showImagePickerController(sourceType: .photoLibrary)
                }
                else {
//                    accessGranted = false
                }
            })
        }
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
        //        return accessGranted
    }
    
    func presentLibraryUsageSettings()
    {
        let alertController = UIAlertController(title: "Error", message: "Enable photo permissions in settings", preferredStyle: .alert)
        alertController.view.tintColor = UIColor.black
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings as URL)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
            self.showImagePickerController(sourceType: .camera)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                    self.showImagePickerController(sourceType: .camera)
                } else {
                    print("Permission denied")
                }
            }
        @unknown default:
            fatalError()
        }
    }
    
    func presentCameraSettings()
    {
        let alertController = UIAlertController(title: "Error",
                                                message: "Camera access is denied",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        self.controller.present(alertController, animated: true)
    }
    
}
extension MediaPickerHelper : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.controller.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let chosenImage = info[.editedImage] as? UIImage{
            self.callbackForImage!(chosenImage)

        }else if let videoURL = info[UIImagePickerController.InfoKey.referenceURL] as? NSURL {
            self.callbackForVideo!(videoURL)
            
        }

//        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            if let chosenImage = info[.editedImage] as? UIImage{
//                self.callbackForImage!(chosenImage)
//
//            }
//
//            let fixedImaage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
//            self.callbackForImage!(fixedImaage)
//
//        }
        
        self.controller.dismiss(animated: true, completion: nil)
    }
}




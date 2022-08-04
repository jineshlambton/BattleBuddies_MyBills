//
//  BaseVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit
import MBProgressHUD
import FirebaseStorage

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func openActionSheetToPickImage(isImagePicked : Bool = false)
    {
        let getPhotoActionSheet = UIAlertController(title: "LBL_GET_PHOTO".localizedLanguage(), message: "LBL_SELECT_IMG_FOR_PROFILE".localizedLanguage(), preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "LBL_TAKE_PHOTO".localizedLanguage(), style: .default){(ACTION) in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.camera
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        }
        let choosePhotoAction = UIAlertAction(title: "LBL_FROM_GALLARY".localizedLanguage(), style: .default)
        {(ACTION) in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        }
        let removePhotoAction = UIAlertAction(title: "LBL_REMOVE_PHOTO".localizedLanguage(), style: .default)
        {(ACTION) in
            self.removePhotoTapped()
        }
        
        let cancelPhotoAction = UIAlertAction(title: "LBL_CANCEL".localizedLanguage(), style: .cancel) { (cancelAction) in
            print("Cancel tapped")
        }
        
        getPhotoActionSheet.addAction(takePhotoAction)
        getPhotoActionSheet.addAction(choosePhotoAction)
        if isImagePicked == true {
            getPhotoActionSheet.addAction(removePhotoAction)
        }
        getPhotoActionSheet.addAction(cancelPhotoAction)
        
        present(getPhotoActionSheet, animated: true, completion: nil)
    }
    
    func getPickedImage(img : UIImage) {
        print("Image picked at basevc")
    }
    
    func removePhotoTapped() {
        print("Remove photo tapped at basevc")
    }
    
    func showProgress() {
        let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
        MBProgressHUD.showAdded(to: window!, animated: true)
    }
    
    func hideProgress() {
        let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
        MBProgressHUD.hide(for: window!, animated: true)
    }
    
    func uploadImage(img : UIImage) {
        guard let selectedPhotoData = img.pngData() else{
            return
        }
        let storageRef = Storage.storage().reference()
        let imagenode = storageRef.child("\(UUID().uuidString)")
        imagenode.putData(selectedPhotoData, metadata: nil, completion: { _, error in
            guard error == nil else{
                print("Failed To Upload")
                return
            }
            imagenode.downloadURL(completion: { url , error in
                guard let url = url , error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Download URL : \(urlString)")
                self.uploadedImageURL(url: urlString)
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        })
    }
    
    func uploadedImageURL(url : String) {
        
    }
}


extension BaseVC:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    // MARK: - Image picker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        
        guard let selectedPhotoData = selectedPhoto.pngData() else{
            return
        }
        let storageRef = Storage.storage().reference()
        let imagenode = storageRef.child("\(UUID().uuidString)")
        imagenode.putData(selectedPhotoData, metadata: nil, completion: { _, error in
            guard error == nil else{
                print("Failed To Upload")
                return
            }
            imagenode.downloadURL(completion: { url , error in
                guard let url = url , error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Download URL : \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        })
            getPickedImage(img: selectedPhoto)
            self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

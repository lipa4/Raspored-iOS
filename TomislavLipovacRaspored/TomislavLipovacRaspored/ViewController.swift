//
//  ViewController.swift
//  TomislavLipovacRaspored
//
//  Created by User on 06/04/16.
//  Copyright © 2016 TomislavLipovac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var nazivPredmeta: UITextField!
    @IBOutlet weak var nastavnik: UITextField!
    @IBOutlet weak var vrstaNastave: UITextField!
    @IBOutlet weak var ECTS: UITextField!
    @IBOutlet weak var mjestoOdržavanja: UITextField!
    @IBOutlet weak var pocetak: UITextField!
    @IBOutlet weak var kraj: UITextField!
    @IBOutlet weak var dan: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var gumbSpremi: UIBarButtonItem!
    
    
    var predmet = Predmet?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nazivPredmeta.delegate=self
        nastavnik.delegate=self
        vrstaNastave.delegate=self
        ECTS.delegate=self
        mjestoOdržavanja.delegate=self
        pocetak.delegate=self
        kraj.delegate=self
        dan.delegate=self
        
        if let predmet = predmet {
            navigationItem.title = predmet.nazivPredmeta
            nazivPredmeta.text   = predmet.nazivPredmeta
            nastavnik.text=predmet.nastavnik
            vrstaNastave.text=predmet.vrstaNastave
            ECTS.text=String(predmet.ECTSbodovi)
            mjestoOdržavanja.text=predmet.mjestoOdrzavanja
            pocetak.text=predmet.pocetakOdrzavanja
            kraj.text=predmet.krajOdrzavanja
            dan.text=predmet.danOdrzavanja
            photoImageView.image = predmet.slika
            
        }
        
        provjeraSvihUnosa()
        
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if gumbSpremi===sender{
            let name=nazivPredmeta.text ?? ""
            let teacher=nastavnik.text ?? ""
            let classType=vrstaNastave.text ?? ""
            let ects=Int(ECTS.text!)!
            let classroom=mjestoOdržavanja.text ?? ""
            let start=pocetak.text ?? ""
            let end=kraj.text ?? ""
            let day=dan.text ?? ""
            let photo=photoImageView.image
            
            predmet=Predmet(nazivPredmeta: name,danOdrzavanja: day,pocetakOdrzavanja: start,krajOdrzavanja: end,mjestoOdrzavanja: classroom,vrstaNastave: classType,nastavnik: teacher,ECTSbodovi: ects,slika: photo)
        }
    }
    
    func provjeraSvihUnosa(){
        if nazivPredmeta.text!.isEmpty != true &&
            nastavnik.text!.isEmpty != true &&
            vrstaNastave.text!.isEmpty != true &&
            ECTS.text!.isEmpty != true &&
            mjestoOdržavanja.text!.isEmpty != true &&
            pocetak.text!.isEmpty != true &&
            kraj.text!.isEmpty != true &&
            dan.text!.isEmpty != true {
            
            gumbSpremi.enabled=true
        }
        else{
            gumbSpremi.enabled=false
        }
        
    }
    
    @IBAction func odustaniGumb(sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        provjeraSvihUnosa()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
        @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        dan.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
}


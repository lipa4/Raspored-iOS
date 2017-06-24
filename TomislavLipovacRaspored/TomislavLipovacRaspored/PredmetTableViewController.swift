//
//  PredmetTableViewController.swift
//  TomislavLipovacRaspored
//
//  Created by User on 06/04/16.
//  Copyright © 2016 TomislavLipovac. All rights reserved.
//

import UIKit

class PredmetTableViewController: UITableViewController {
    
    var predmeti = [Predmet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()

        
        if let spremljeniPredmeti = dohvatiPredmete() {
            predmeti += spremljeniPredmeti
        } else {
            // Load the sample data.
            napraviTestObjekte()
        }
    
    }

    func napraviTestObjekte(){
        let photo1 = UIImage(named: "apple")
        let predmet1 = Predmet(nazivPredmeta: "Razvoj iOS aplikacija",danOdrzavanja: "Srijeda",pocetakOdrzavanja: "14:00",krajOdrzavanja: "17:00", mjestoOdrzavanja: "MACLab",vrstaNastave: "PRIN",nastavnik: "Bojan Nožica",ECTSbodovi:6,slika: photo1)!
        
        let photo2 = UIImage(named: "java")
        let predmet2 = Predmet(nazivPredmeta: "Web aplikacije u Javi",danOdrzavanja: "Četvrtak",pocetakOdrzavanja: "16:00",krajOdrzavanja: "18:00",mjestoOdrzavanja: "1-104",vrstaNastave: "PRIN",nastavnik: "Marko Horvat",ECTSbodovi: 6,slika: photo2)!
        
        let photo3 = UIImage(named: "tux")
        let predmet3 = Predmet(nazivPredmeta: "Uvod u UNIX sustave",danOdrzavanja: "Ponedjeljak",pocetakOdrzavanja: "12:00",krajOdrzavanja: "14:00",mjestoOdrzavanja: "MSLab",vrstaNastave: "PRIN",nastavnik: "Ivica Dodig",ECTSbodovi: 6,slika: photo3)!
        
        predmeti += [predmet1,predmet2,predmet3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return predmeti.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PredmetTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PredmetTableViewCell
        
        
        let predmet = predmeti[indexPath.row]
        
        
        cell.nazivPredmeta.text = predmet.nazivPredmeta
        cell.slikaPredmeta.image = predmet.slika
        cell.danVrijeme.text=predmet.danOdrzavanja+" "+predmet.pocetakOdrzavanja
        cell.prostorija.text=predmet.mjestoOdrzavanja
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            predmeti.removeAtIndex(indexPath.row)
            spremiPredmete()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as?
            ViewController, predmet = sourceViewController.predmet {
         
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                predmeti[selectedIndexPath.row] = predmet
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
                let newIndexPath = NSIndexPath(forRow: predmeti.count, inSection: 0)
                predmeti.append(predmet)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            spremiPredmete()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "prikazDetalja" {
            let predmetDetailViewController = segue.destinationViewController as! ViewController
            
            // Get the cell that generated this segue.
            if let selectedPredmetCell = sender as? PredmetTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedPredmetCell)!
                let selectedPredmet = predmeti[indexPath.row]
                predmetDetailViewController.predmet = selectedPredmet
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
    }
    
    func spremiPredmete() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(predmeti, toFile: Predmet.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func dohvatiPredmete() -> [Predmet]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Predmet.ArchiveURL.path!) as? [Predmet]
    }

}

//
//  Predmet.swift
//  TomislavLipovacRaspored
//
//  Created by User on 06/04/16.
//  Copyright © 2016 TomislavLipovac. All rights reserved.
//
import UIKit
import Foundation

class Predmet: NSObject, NSCoding {
    
    var nazivPredmeta:String
    var danOdrzavanja:String
    var pocetakOdrzavanja:String
    var krajOdrzavanja:String
    var mjestoOdrzavanja:String
    var vrstaNastave:String
    var nastavnik:String
    var ECTSbodovi:Int	
    var slika : UIImage?
    
    init?(nazivPredmeta: String, danOdrzavanja:String,pocetakOdrzavanja:String,krajOdrzavanja:String,mjestoOdrzavanja:String,vrstaNastave:String,nastavnik:String,ECTSbodovi:Int,slika:UIImage?){
        self.nazivPredmeta=nazivPredmeta;
        self.danOdrzavanja=danOdrzavanja;
        self.pocetakOdrzavanja=pocetakOdrzavanja;
        self.krajOdrzavanja=krajOdrzavanja;
        self.mjestoOdrzavanja=mjestoOdrzavanja;
        self.vrstaNastave=vrstaNastave;
        self.nastavnik=nastavnik;
        self.ECTSbodovi=ECTSbodovi;
        self.slika=slika;
        super.init()
    }
    struct PropertyKey {
        static let nazivKey = "name"
        static let dayKey = "day"
        static let startKey="start"
        static let krajKey="end"
        static let classroomKey="classroom"
        static let typeKey="type"
        static let teacherKey="teacher"
        static let ectsKey="ects"
        static let photoKey = "photo"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(nazivPredmeta, forKey: PropertyKey.nazivKey)
        aCoder.encodeObject(slika, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(ECTSbodovi, forKey: PropertyKey.ectsKey)
        aCoder.encodeObject(danOdrzavanja, forKey: PropertyKey.dayKey)
        aCoder.encodeObject(pocetakOdrzavanja, forKey: PropertyKey.startKey)
        aCoder.encodeObject(krajOdrzavanja, forKey: PropertyKey.krajKey)
        aCoder.encodeObject(nastavnik, forKey: PropertyKey.teacherKey)
        aCoder.encodeObject(vrstaNastave, forKey: PropertyKey.typeKey)
        aCoder.encodeObject(mjestoOdrzavanja, forKey: PropertyKey.classroomKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nazivKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let ects = aDecoder.decodeIntegerForKey(PropertyKey.ectsKey)
        
        let day = aDecoder.decodeObjectForKey(PropertyKey.dayKey) as! String
        let start = aDecoder.decodeObjectForKey(PropertyKey.startKey) as! String
        let end = aDecoder.decodeObjectForKey(PropertyKey.krajKey) as! String
        let teacher = aDecoder.decodeObjectForKey(PropertyKey.teacherKey) as! String
        let type = aDecoder.decodeObjectForKey(PropertyKey.nazivKey) as! String
        let place = aDecoder.decodeObjectForKey(PropertyKey.classroomKey) as! String

        // Must call designated initializer.
        self.init(nazivPredmeta:name, danOdrzavanja: day, pocetakOdrzavanja: start,krajOdrzavanja: end,mjestoOdrzavanja: place, vrstaNastave: type,nastavnik: teacher,ECTSbodovi: ects,slika: photo)
    }
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("predmeti")
}

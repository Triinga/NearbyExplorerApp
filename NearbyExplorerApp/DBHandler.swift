//
//  DBHandler.swift
//  NearbyExplorerApp
//
//  Created by Tringa on 2/19/24.
//

import Foundation
import SQLite3

class Databasehandler {
    let databaseName : String = "nearbyappDB"
    let databaseExtension : String = "db"
    var db : OpaquePointer! = nil
    
    init() {
         prepareDatafile()
         db = openDatabase()
    }
    
    func executeSelect(email:String , password:String)->loginData{
        
        var data = loginData()
        let query = "select * from logindata where email = '"+email+"' and password = '"+password+"'"
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            if  sqlite3_step(queryStatement) == SQLITE_ROW
            {
                let c1 = sqlite3_column_text(queryStatement, 0)
                if c1 != nil{
                    data.name = String(cString: c1!)
                }
                let c2 = sqlite3_column_text(queryStatement, 1)
                if c2 != nil{
                    data.email = String(cString: c2!)
                }
                let c3 = sqlite3_column_text(queryStatement, 2)
                if c3 != nil{
                    data.password = String(cString: c3!)
                }
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            
        }
        
        sqlite3_finalize(queryStatement!)
        return data
    }
    
    func loginAuthentication(email:String , password:String)->Bool{
        
        let query = "select * from logindata where email = '"+email+"' and password = '"+password+"'"
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            if  sqlite3_step(queryStatement) == SQLITE_ROW
            {
                sqlite3_finalize(queryStatement)
                return true
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("'insert into ':: could not be prepared::\(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return false
    }
    
    func executeQuery(query: String)->Bool{
        
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting hero: \(errmsg)")
            }
            else{
                return true
            }
            
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("'insert into ':: could not be prepared::\(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return false
    }
    
    //deleting from database
    
    func deleteQuery(query: String)->Bool{
        
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &deleteStatement, nil) == SQLITE_OK {
    
            if sqlite3_step(deleteStatement) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting hero: \(errmsg)")
                
            } else {
               return true
                
                
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("'insert into ':: could not be prepared::\(errmsg)")

        }
    
    
    
    
        sqlite3_finalize(deleteStatement)
    
    
        print("delete")
        return false
    
    //to check if email exists
    }
    func doesEmailExist(email: String) -> Bool {
        let query = "SELECT COUNT(*) FROM logindata WHERE email = '\(email)'"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            defer {
                sqlite3_finalize(queryStatement)
            }
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let count = sqlite3_column_int(queryStatement, 0)
                return count > 0
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Query could not be prepared: \(errmsg)")
        }
        
        return false
    }

    
    //Copy database for first time

    func prepareDatafile()
    {
        let docUrl=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(docUrl)
        let fdoc_url=URL(fileURLWithPath: docUrl).appendingPathComponent("\(databaseName).\(databaseExtension)")
        
        let filemanager=FileManager.default
        
        if !FileManager.default.fileExists(atPath: fdoc_url.path){
            do{
                let localUrl=Bundle.main.url(forResource: databaseName, withExtension: databaseExtension)
                print(localUrl?.path ?? "")
                
                try filemanager.copyItem(atPath: (localUrl?.path)!, toPath: fdoc_url.path)
                
                print("Database copied to simulator-device")
            }catch
            {
                print("error while copying")
            }
        }
        else{
            print("Database alreayd exists in similator-device")
        }
    }
    
    
    
   
    //Open Connection to Database
  
    func openDatabase() -> OpaquePointer? {
        
        let docUrl=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(docUrl)
        let fdoc_url=URL(fileURLWithPath: docUrl).appendingPathComponent("\(databaseName).\(databaseExtension)")
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fdoc_url.path, &db) == SQLITE_OK {
            print("DB Connection Opened, Path is :: \(fdoc_url.path)")
            return db
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            return nil
        }
        
    }

}

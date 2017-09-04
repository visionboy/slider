//
//  SQLiteManager.swift
//  slider
//
//  Created by 알버트 on 2017. 8. 21..
//  Copyright © 2017년 visionboy.me. All rights reserved.
//
import UIKit

class SQLiteManager: NSObject {
    
    /// 单例
    static let shareInstance: SQLiteManager = SQLiteManager()
    
    override init() {
        super.init()
        openDB("demo.sqlite")
    }
    
    var db: FMDatabase?
    func openDB(name: String)
    {
        let filemgr = NSFileManager.defaultManager()
        
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        let databasePath = dirPaths[0].URLByAppendingPathComponent("contacts.db").path!
        
        // 2.创建数据库对象
        db = FMDatabase(path: databasePath as String)
        
        // 3.打开数据库
        // open()特点: 如果数据库文件不存在就创建一个新的, 如果存在就直接打开
        if !db!.open()
        {
            print("打开数据库失败")
            return
        }
        
        // 4.创建表
        if !createTable()
        {
            print("创建数据库失败")
            return
        }
    }
    
    /**
     创建表
     */
    func createTable() ->Bool
    {
        // 1.编写SQL语句
        let sql = "CREATE TABLE memo( no INTEGER PRIMARY KEY AUTOINCREMENT, ctt TEXT, reg_date datetime);"
        
        // 2.执行SQL语句
        // 注意: 在FMDB中, 除了查询以外的操作都称之为更新
        
        if db!.executeStatements(sql) {
            
           // print("Error: \(db!.lastErrorMessage())")
            
        }
     //   return db!.executeUpdate(sql, withArgumentsInArray: nil)
        return db!.executeStatements(sql)
    }
}

//
//  SecondPage.swift
//  slider
//
//  Created by 알버트 on 2017. 8. 14..
//  Copyright © 2017년 visionboy.me. All rights reserved.
//

import UIKit




class MemoPage: UIViewController {
    
    @IBOutlet var menuButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        selectData()
        
    }
    
    @IBAction func MemoRegist(sender: AnyObject) {
        
        if let uvc = self.storyboard?.instantiateViewControllerWithIdentifier("RegistMemo") {
            self.navigationController?.pushViewController(uvc, animated: true)
        }
        
    }
    
    
    
    func selectData() {
        /// 查询语句
        let sql2 = "SELECT no, ctt, reg_date FROM memo ;"
        // 1.查询数据库
        let result = SQLiteManager.shareInstance.db!.executeQuery(sql2, withArgumentsInArray: [0])
        
        
        // 2.从结果集中取出数据
        while result!.next()
        {
            let no = result!.intForColumn("no")
            let ctt = result!.stringForColumn("ctt")
            let regdate = result!.intForColumn("reg_date")
            print("\(no), \(ctt), \(regdate)")
        }
        
    }
    
}

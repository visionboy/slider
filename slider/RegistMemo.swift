//
//  File.swift
//  slider
//
//  Created by 알버트 on 2017. 8. 21..
//  Copyright © 2017년 visionboy.me. All rights reserved.
//

import UIKit

class RegistMemo: UIViewController{

    @IBOutlet var textView: UITextView!
    
    @IBOutlet var btn: UIButton!
    
    var no : String = "";

    override func viewDidLoad() {
        NSLog("%@", no)
        super.viewDidLoad()
        if (no != "") {
            GetMemoDetail(no)
            btn.setTitle("Update", forState: UIControlState.Normal)
        } else {
            btn.setTitle("Add", forState: UIControlState.Normal)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        insertMemo()
    }
    
    @IBAction func insertAction(sender: AnyObject) {
        if (self.textView.text=="") {
            BaseController.BS.alert("Input your message!")
            self.textView.becomeFirstResponder()
        } else {
        
            if (no != "") {
                updateMemo(no)
            } else {
                insertMemo()
            }
            
            //self.navigationController?.popViewControllerAnimated(true)
            
            if let rvc = self.storyboard?.instantiateViewControllerWithIdentifier("MemoList") as? MemoList {
                rvc.gNo = no
                self.navigationController?.pushViewController(rvc, animated: true)
            }

        }
        
    }
    
    func insertMemo() {
        let sql = "INSERT INTO memo (ctt,reg_date) values (?, ?);"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        SQLiteManager.shareInstance.db?.executeUpdate(sql, withArgumentsInArray: [textView.text, dateFormatter.stringFromDate(NSDate())])
    }
    
    func updateMemo(no:String) {
        let sql = "update memo set ctt = ? where no =? ;"
        SQLiteManager.shareInstance.db?.executeUpdate(sql, withArgumentsInArray: [self.textView.text,no])    }
    
    func GetMemoDetail(no:String)  {
        let sql = "SELECT ctt, reg_date FROM memo where no = ? ;"
        // 1.查询数据库
        let result = SQLiteManager.shareInstance.db!.executeQuery(sql, withArgumentsInArray: [no])
        
        // 2.从结果集中取出数据
        while result!.next()
        {

            let ctt = result!.stringForColumn("ctt")
            self.textView.text = ctt

        }
    }
    
    

}

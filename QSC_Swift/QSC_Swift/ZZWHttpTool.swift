//
//  ZZWHttpTool.swift
//  english_Demo_swift
//
//  Created by zhangzhenwei on 17/1/3.
//  Copyright © 2017年 zhangzhenwei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias httpSuccess = (_ result: JSON)->()
typealias httpFailure = (_ error: Error)->()



class ZZWHttpTools {
    
    //请求头
    let requestHeader:HTTPHeaders = ["Platform":"qsc_ios/2.2.0/v6",
                                     "Accept":"application/json"];
    //设置manager属性 (重要)
    var manger:SessionManager? = nil
    
    
    //单例
    static let share = ZZWHttpTools()

    
    func zzwHttpRequest(path: String,parameters:Dictionary<String,Any>?,success:@escaping httpSuccess,failure:@escaping httpFailure) {
        
        _ = getSessionconfig()
        
        manger?.request(path, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: requestHeader).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                debugPrint(response)
                if let data = response.data{
                    let json = JSON(data: data)
                    //                    success(json)
                    success(json)
                    
                }
            case .failure(let error):
                print(error)
                //                failure(error)
                failure(error)
            }
            
        })
    }
    
    
    
    func getWithPath(path: String,parameters: Dictionary<String,Any>?,success: @escaping ((_ result: JSON) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        _ = getSessionconfig()
        
        manger?.request(path, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: requestHeader).validate().responseJSON(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                debugPrint(response)
                if let data = response.data{
                    let json = JSON(data: data)
                    success(json)
                    
                }
            case .failure(let error):
                print(error)
                failure(error)
            }
        })
    }
    
    
    
    
    func getSessionconfig() -> SessionManager {
        //配置 , 通常默认即可
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        //设置超时时间为15S
        config.timeoutIntervalForRequest = 15
        //根据config创建manager
        manger = SessionManager(configuration: config)
        return manger!
    }

}

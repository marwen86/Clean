//
//  ViewController.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 30/04/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dataLocalService = DataLocalDataService()
        let dataRemoteService = DataRemoteService<EuroSportApi>(endPoint: .getVideosStories)
        let mediaRepository = DefaultMediaRepository(dataRemoteService: dataRemoteService, dataLocalService: dataLocalService)
        let useCase = SearchMediaDataUseCase(mediaRepository: mediaRepository)
        useCase.execute(cached: { (result: Result<EsportMedias, Error>) in
            print(result)
        }) { result in
            print(result)
        }
    }


}


//
//  PeopleInSpaceToView.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

class PeopleInSpaceToView {
    var textToDisplay = ""
    func getPeopleInSpace (callback : @escaping (String) -> Void) {
        let httpService = HttpService<PeopleInSpace>()
        httpService.getIssData(for: Endpoints.peopleInSpace, param: nil, callback: { statusCode in
            if statusCode == StatusCode.success {
                let data = httpService.data
                if let data = data {
                    self.textToDisplay = "There is \(data.number) people in space : \n"
                    for people in data.people {
                        self.textToDisplay += "- \(people.name) in \(people.craft)\n"
                    }
                    self.textToDisplay.removeLast()
                    callback(self.textToDisplay)
                }
            }
        })
    }
}

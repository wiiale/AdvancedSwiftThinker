//
//  TableViewDataSource.swift
//  T01-Hashable-Footprint
//
//  Created by lili on 2017/12/11.
//  Copyright © 2017年 fun. All rights reserved.
//

import UIKit

class TableViewControllerDataSource: NSObject, UITableViewDataSource {
    var cities: [City]
    var selectedCitiesSet: Set<City>
    weak var owner: TableViewController?
    
    init(cities: [City], selectedCitiesSet: Set<City>, owner: TableViewController?) {
        self.cities = cities
        self.selectedCitiesSet = selectedCitiesSet
        self.owner = owner
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellResueId, for: indexPath) as! TableCityCell
        cell.textLabel?.text = cities[indexPath.row].name
        cell.footprintImageView.isHidden = !selectedCitiesSet.contains(cities[indexPath.row])
        return cell
    }
}


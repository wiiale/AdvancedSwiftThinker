//
//  Created by lili on 2018/7/11.
//
//  Copyright © 2018年 fun. All rights reserved.
//

import XCTest
@testable import Footprint

class FootprintTests: XCTestCase {
    
    var controller: TableViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller = (UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TableViewController") as! TableViewController)
        _ = controller.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controller = nil
        super.tearDown()
    }
    
    func testLoadToDos() {
        let initState = TableViewController.State()
        let (_, command) = controller.reducer(initState, .loadCities)
        XCTAssertNotNil(command)
        switch command! {
        case .loadCities(let handler):
            handler([City(name: "2", province: "2"), City(name: "3", province: "3")])
            XCTAssertEqual(controller.store.state.dataSource.cities, [City(name: "2", province: "2"), City(name: "3", province: "3")])
        }
    }
    
    
    func testUpdateCitiesView() {
        let allCities = [City(name: "1", province: "1"),
                         City(name: "2", province: "2"),
                         City(name: "3", province: "3")]
        let state1 = TableViewController.State(
            dataSource: TableViewControllerDataSource(cities: allCities,
                                                      selectedCitiesSet: [],
                                                      owner: nil)
        )
        let state2 = TableViewController.State(
            dataSource: TableViewControllerDataSource(cities: allCities,
                                                      selectedCitiesSet: Set<City>(allCities[0...1]),
                                                      owner: nil)
        )
        let state3 = TableViewController.State(
            dataSource: TableViewControllerDataSource(cities: allCities,
                                                      selectedCitiesSet: Set<City>(allCities[1...2]),
                                                      owner: nil)
        )
        
        controller.stateDidChanged(state: state2, previousState: state1, command: nil)
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), allCities.count)
        XCTAssertEqual(controller.cell(row: 0).footprintImageView.isHidden, false)
        XCTAssertEqual(controller.cell(row: 1).footprintImageView.isHidden, false)
        XCTAssertEqual(controller.cell(row: 2).footprintImageView.isHidden, true)
        
        controller.stateDidChanged(state: state3, previousState: state2, command: nil)
        XCTAssertEqual(controller.cell(row: 0).footprintImageView.isHidden, true)
        XCTAssertEqual(controller.cell(row: 1).footprintImageView.isHidden, false)
        XCTAssertEqual(controller.cell(row: 2).footprintImageView.isHidden, false)
    }
    
    func testTapCity() {
        let allCities = [City(name: "1", province: "1"),
                         City(name: "2", province: "2"),
                         City(name: "3", province: "3")]
        let state1 = TableViewController.State(
            dataSource: TableViewControllerDataSource(cities: allCities, selectedCitiesSet: [], owner: nil)
        )
        controller.store.state = state1
        controller.stateDidChanged(state: state1, previousState: nil, command: nil)
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), allCities.count)
        XCTAssertEqual(controller.cell(row: 0).footprintImageView.isHidden, true)
        XCTAssertEqual(controller.cell(row: 1).footprintImageView.isHidden, true)
        XCTAssertEqual(controller.cell(row: 2).footprintImageView.isHidden, true)
        
        controller.tapCell(row: 0)
        XCTAssertEqual(controller.cell(row: 0).footprintImageView.isHidden, false)
        
        controller.tapCell(row: 1)
        XCTAssertEqual(controller.cell(row: 1).footprintImageView.isHidden, false)
        
        controller.tapCell(row: 2)
        XCTAssertEqual(controller.cell(row: 2).footprintImageView.isHidden, false)
    }
}

fileprivate extension TableViewController {
    func cell(row: Int) -> TableCityCell {
        return tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TableCityCell
    }
    
    func tapCell(row: Int) {
        tableView(tableView, didSelectRowAt: IndexPath(row: row, section: 0))
    }
}


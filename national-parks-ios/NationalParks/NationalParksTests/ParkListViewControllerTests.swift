//
//  ParkListViewControllerTests.swift
//  NationalParksTests
//
//  Created by Sean Grogg on 4/22/22.
//

import XCTest
@testable import NationalParks

class ParkListViewControllerTests: XCTestCase {
    
    var systemUnderTest: ParkListViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.systemUnderTest = navigationController.topViewController as? ParkListViewController
        
        UIApplication.shared.windows
            .filter{ $0.isKeyWindow }
            .first!
            .rootViewController = self.systemUnderTest
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(self.systemUnderTest.view)
    }


    func testTableViewLoadsParks() {
        //given
        let mockParkService = MockParkService()
        let mockParks = [
                Park(named: "Cuyahoga Valley", description: "Waterfalls, hills, and trails, oh my!", imageURL: "https://static.onecms.io/wp-content/uploads/sites/28/2016/12/cuyahoga-valley-national-park-ohio-brandywine-falls-CUYAHOGA1202.jpg", state: "OH"),
                Park(named: "Death Valley", description: "Unsurprisingly little life to be found here", imageURL: "https://drupal8-prod.visitcalifornia.com/sites/drupal8-prod.visitcalifornia.com/files/styles/fluid_1200/public/vc_ca101_nationalparks_deathvalleymesquiteflats_rf_452960329_1280x640.jpg?itok=w4281Gd8", state: "NV/CA"),
                Park(named: "Gateway Arch", description: "It's literally a building I don't understand how this is a park.", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/St_Louis_night_expblend_cropped.jpg/1200px-St_Louis_night_expblend_cropped.jpg", state: "MI")]
        
        mockParkService.mockParks = mockParks
        
        self.systemUnderTest.viewDidLoad()
        self.systemUnderTest.parkService = mockParkService
        
        
        //when
        self.systemUnderTest.viewWillAppear(false)
        
        //then
        XCTAssertEqual(mockParks.count, self.systemUnderTest.parks.count)
        XCTAssertEqual(mockParks.count, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        
        
  
    }
    
    class MockParkService: ParkService{
        var mockParks: [Park]?
        var mockError: Error?
        
        override func getParks(completion: @escaping ([Park]?, Error?) -> ()) {
            completion(mockParks, mockError)
        }
    }

}

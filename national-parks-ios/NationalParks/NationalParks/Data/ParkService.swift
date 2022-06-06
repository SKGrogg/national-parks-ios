//
//  ParkService.swift
//  NationalParks
//
//  Created by Sean Grogg on 4/10/22.
//

import Foundation

enum ParkCallingError: Error{
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
}

class ParkService {
    private let urlString = "https://run.mocky.io/v3/a49571c8-4b29-42a2-8cb5-32ddbec36a48" 
    
    func getParks(completion: @escaping ([Park]?, Error?) -> ()) {
        guard let url = URL(string: self.urlString) else {
            DispatchQueue.main.async { completion(nil,
                ParkCallingError.problemGeneratingURL)}
        return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil,
                    ParkCallingError.problemGettingDataFromAPI)}
            return
            }
            
            do {
                let parkResult = try JSONDecoder().decode(Park.ParkResult.self, from: data)
                
                DispatchQueue.main.async {completion(parkResult.parks, nil)}
            } catch (let error) {
                print(error)
                DispatchQueue.main.async {completion(nil, ParkCallingError.problemDecodingData)}
            }
        }
        task.resume()
    }
    
    
    /*
    func getParks() -> [Park] {
        
        return [
            Park(named: "Dry Tortugas", description: "Small lil' fort island", imageURL: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/b7/92/64/dry-tortugas-national.jpg?w=1200&h=-1&s=1", state: "FL"),
            Park(named:"Yellowstone", description: "Note: Stones a variety of colors", imageURL: "https://www.visittheusa.com/sites/default/files/styles/16_9_1280x720/public/2016-10/Yellowstone.jpg?itok=5kKxu0Pk", state: "WY"),
            Park(named: "Grand Canyon", description: "Big Hole in Ground", imageURL: "https://www.undercanvas.com/wp-content/uploads/2021/07/Grand-Canyon-scaled.jpg", state: "AZ"),
            Park(named:"Redwood", description: "No gulf-stream waters here", imageURL: "https://www.planetware.com/photos-large/USCA/california-redwood-national-and-state-parks-boy-scout-tree-trail.jpg", state: "CA"),
            Park(named:"Zion", description: "Great for Instagram", imageURL: "https://images.unsplash.com/photo-1524274165673-750e79bf7e2e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8emlvbiUyMG5hdGlvbmFsJTIwcGFya3xlbnwwfHwwfHw%3D&w=1000&q=80", state: "UT"),
            Park(named:"Yosemite", description: "Favorite destination for crazy climbers", imageURL: "https://www.history.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTU3ODc4NjAwMjkxNzIyNTY5/yosemite-3.jpg", state: "CA"),
            Park(named: "Arches", description: "Be Warned: No McDonalds on premises", imageURL: "https://www.myutahparks.com/wp-content/uploads/2021/02/Arches-DelicateArch-LaSalMountains_DP_1600.jpg", state: "UT"),
            Park(named:"Glacier", description: "Come see the glaciers while supplies last!", imageURL: "https://www.tripsavvy.com/thmb/3AO3wQNCRdi3MnelMlifgUnimUc=/2400x1800/smart/filters:no_upscale()/IMG_7115-e21fc727cf734a2fb38de800930605b3.jpg", state: "MT"),
            Park(named:"Sequoia", description: "Biggest trees in the world", imageURL: "https://www.travelinusa.us/wp-content/uploads/sites/3/2013/06/Sequoia-National-Park-1.jpg", state: "CA"),
            Park(named: "Olympic", description: "There is a beach here that looks like the beach from Twilight", imageURL: "https://s27363.pcdn.co/wp-content/uploads/2021/02/Hurricane-Ridge-Olympic-NP.jpg.optimal.jpg", state: "WA"),
            Park(named: "Carlsbad Caverns", description: "Caves with creepy crawlies and bumps in the night", imageURL: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F28%2F2020%2F03%2F20%2Fcarlsbad-cavern-green-CBAD0320.jpg", state: "TX"),
            Park(named: "Hawai'i Volcanos",description: "See name for description", imageURL: "https://national-park.com/wp-content/uploads/2016/04/Welcome-to-Hawaii-Volcanoes-National-Park.jpg", state: "HA"),
            Park(named:"Joshua Tree", description: "Desert with some dry looking trees", imageURL: "https://www.visitcalifornia.com/sites/visitcalifornia.com/files/styles/welcome_image/public/VCW_D_Jtree_heroDE_JoshuaTrees_1280x642_downsized.jpg", state: "CA"),
            Park(named: "Everglades", description: "Watch out for 'gators", imageURL: "https://www.tripsavvy.com/thmb/7bl8TiCBOOMcw81d9J6yKAoOVxw=/2016x1134/smart/filters:no_upscale()/aerial-view-of-everglades-national-park-in-florida--usa-1174367665-431fee8fa1e341748e5f185e031e5163.jpg", state: "FL"),
            Park(named: "Crater Lake", description: "Formed from the crater of a meteorite, this is one of the prettiest things you ever will see", imageURL: "https://travel.mqcdn.com/mapquest/travel/wp-content/uploads/2020/07/GettyImages-909718788-scaled.jpg", state: "OR"),
            Park(named: "Petrified Forest", description: "The trees are so scared", imageURL: "https://th-thumbnailer.cdn-si-edu.com/BT1yAMar_H84C2Oy6GuL8fikkxQ=/1000x750/filters:no_upscale()/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/25/6a/256a1ea9-20a9-4499-a872-6106432b11fe/petrified.jpg", state: "AZ"),
            Park(named: "Shenandoah", description: "Beautiful vistas of foliage in the Fall", imageURL: "https://cdn.britannica.com/79/176979-050-DC64B229/Little-Stony-Man-Cliffs-Blue-Ridge-Mountains.jpg", state: "VA"),
            Park(named: "Mesa Verde", description: "Site of beautifully preserve Pubeloan cliff dwellings ", imageURL: "https://www.colorado.com/sites/default/files/listing_images/profile/3742/0-co_photoproject2007_0215.jpg", state: "CO")
        ]
    }*/
}

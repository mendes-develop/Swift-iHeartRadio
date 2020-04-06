import Foundation

struct Episode : Codable {
    let id: Int
    let title: String
    let mediaURL: URL
    let progressPercentage: Double
    let publishedDate: Date
    let listened: Bool   
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Episode : CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(id)"
    }
}

// -- do not edit above --
func next(episodes: [Episode], from episode: Episode) -> Episode? {

    
        // let publishedDate: Date
        // let listened: Bool  
        
        // var sortedList = [a,b,c].sort((a,b, index1, index2) => { return a.publishedDate > b.publishedDate})
        var selectedEpisode: Episode? = nil
        for current in episodes {
            if !current.listened && current.publishedDate > episode.publishedDate {
                if let selectedEpisode = selectedEpisode && current.publishedDate < selectedEpisode.publishedDate {
                    selectedEpisode = current
                } else if selectedEpisode == nil {
                    selectedEpisode = current
                }
            }
        }
        return selectedEpisode
        
        var sortedList = episodes.sorted(by: { (episode1, episode2) in 
            return episode1.publishedDate < episode2.publishedDate
        })
        
        guard let episodeIndex = sortedList.firstIndex(of: episode) else {
            return nil
        }
        
        var slicedArray = sortedList[episodeIndex+1..<sortedList.count]
        
        let first: Episode? = slicedArray.first(where: { $0.listened == true })

    return first
}
// -- do not edit below --


let decoder = JSONDecoder()

let episodesInput = readLine(strippingNewline: true)!.data(using: .utf8)!
let episodes = try! decoder.decode([Episode].self, from: episodesInput)

let fromInput = readLine(strippingNewline: true)!.data(using: .utf8)!
let from = try! decoder.decode(Episode.self, from: fromInput)


if let episode = next(episodes: episodes, from: from) {
    print("\(episode.id)")
}



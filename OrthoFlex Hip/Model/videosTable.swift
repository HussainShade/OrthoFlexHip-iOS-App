//
//  videosTable.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 23/02/24.
//

import Foundation


struct GetVideosTable: Codable {
    let status: Bool
    let data: [getVideosTableData]
}

// MARK: - Datum
struct getVideosTableData: Codable {
    let videoID: Int
    let videoName, videoFile: String

    enum CodingKeys: String, CodingKey {
        case videoID = "video_id"
        case videoName = "video_name"
        case videoFile = "video_file"
    }
}

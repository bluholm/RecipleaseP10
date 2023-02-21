//
//  FileManagerTests.swift
//  RecipleaseTests
//
//  Created by Marc-Antoine BAR on 2023-02-21.
//

import XCTest
@testable import Reciplease

final class FileManagerTests: XCTestCase {

    func testSaveFiles_WhenValidUrlAndFileName_ThenFileIsSaved() {
        let url = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
        let filesRepo = DocumentsDirectoryRepository()
        let expectation = XCTestExpectation(description: "saveFiles a écrit correctement le fichier")
        filesRepo.saveFiles(url: url, fileName: "test.png")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            let documentsDirectory = filesRepo.getDocumentsDirectory().path
            let filePath = "\(documentsDirectory)/test.png"
            XCTAssertTrue(FileManager.default.fileExists(atPath: filePath))
            expectation.fulfill()
            try? FileManager.default.removeItem(atPath: filePath)
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testSaveFiles_WhenInvalidUrl_ThenFileIsNotSaved() {
        let filesRepo = DocumentsDirectoryRepository()
        let testFilePath = "\(filesRepo.getDocumentsDirectory().path)/test.jpg"
        FileManager.default.createFile(atPath: testFilePath, contents: nil, attributes: nil)
        XCTAssertTrue(FileManager.default.fileExists(atPath: testFilePath))
        filesRepo.deleteFiles("test.jpg")
        XCTAssertFalse(FileManager.default.fileExists(atPath: testFilePath))
    }

    func testDeleteFiles_WhenValidFileName_ThenFileIsDeleted() {
        let filesRepo = DocumentsDirectoryRepository()
        let expectation = XCTestExpectation(description: "getData completionHandler a été appelé")
        let url = URL(string: "https://example.com/image.jpg")!
        filesRepo.getData(from: url) { data, _, _ in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testDeleteFiles_WhenInvalidFileName_ThenNoFileIsDeleted() {
        let filesRepo = DocumentsDirectoryRepository()
        let documentsDirectory = filesRepo.getDocumentsDirectory()
        let expectedDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        XCTAssertEqual(documentsDirectory, expectedDocumentsDirectory)
    }

}

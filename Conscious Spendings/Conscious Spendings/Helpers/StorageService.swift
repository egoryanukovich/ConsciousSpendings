//
//  StorageService.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import Foundation

enum FileManagerPath: String {
  case dailySpendings
}

enum AppError: Error {
  case withoutInfo
  case invalidSpendings
}

struct ErrorWrapper: Identifiable {
  var id: String {
    error.localizedDescription
  }

  let error: Error
  let guidance: String
}

final class StorageService {
  @discardableResult
  static func saveData<T: Codable>(_ data: T, to path: FileManagerPath) -> ErrorWrapper? {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    guard let documentURL = (directoryURL?.appendingPathComponent(path.rawValue).appendingPathExtension("json")) else {
      return ErrorWrapper(error: AppError.withoutInfo, guidance: "can't find document url")
    }
    let jsonEncoder = JSONEncoder()
    do {
      let data = try jsonEncoder.encode(data)
      do {
        try data.write(to: documentURL, options: .noFileProtection)
      } catch {
        return ErrorWrapper(error: error, guidance: "Cannot save data!!!\nSee error: \(error.localizedDescription)")
      }
    } catch {
      return ErrorWrapper(error: error, guidance: "Cannot encode data!!!\nSee error: \(error.localizedDescription)")
    }
    return nil
  }
  
  static func fetchData<T: Codable>(of type: T.Type, from path: FileManagerPath) -> (result: T?, error: ErrorWrapper?) {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    guard let documentURL = (directoryURL?.appendingPathComponent(path.rawValue).appendingPathExtension("json")) else { return (nil, ErrorWrapper(error: AppError.withoutInfo, guidance: "can't find document url")) }
    do {
      let data = try Data(contentsOf: documentURL)
      do {
        let jsonDecoder = JSONDecoder()
        return (try jsonDecoder.decode(type, from: data), nil)
      } catch {
        return (nil, ErrorWrapper(error: error, guidance: "Cannot fetch data!!!\nSee error: \(error.localizedDescription)"))
      }
    } catch {
      return (nil, ErrorWrapper(error: error, guidance: "Cannot find document!!!\nSee error: \(error.localizedDescription)"))
    }
  }
}

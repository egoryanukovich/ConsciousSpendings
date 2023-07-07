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

// TODO: - add error handling
final class StorageService {
  static func saveData<T: Codable>(_ data: T, to path: FileManagerPath) {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    guard let documentURL = (directoryURL?.appendingPathComponent(path.rawValue).appendingPathExtension("json")) else { return }
    let jsonEncoder = JSONEncoder()
    do {
      let data = try jsonEncoder.encode(data)
      do {
        try data.write(to: documentURL, options: .noFileProtection)
      } catch {
        print("Error...Cannot save data!!!See error: \(error.localizedDescription)")
      }
    } catch {
      print("Error...Cannot save data!!!See error: \(error.localizedDescription)")
    }
  }
  
  static func fetchData<T: Codable>(of type: T.Type, from path: FileManagerPath) -> T? {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    guard let documentURL = (directoryURL?.appendingPathComponent(path.rawValue).appendingPathExtension("json")) else { return nil }
    do {
      let data = try Data(contentsOf: documentURL)
      do {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(type, from: data)
      } catch {
        print("Error...Cannot save data!!!See error: \(error.localizedDescription)")
      }
    } catch {
      print("Error...Cannot save data!!!See error: \(error.localizedDescription)")
    }
    return nil
  }
}

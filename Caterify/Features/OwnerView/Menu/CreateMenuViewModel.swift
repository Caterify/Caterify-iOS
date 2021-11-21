//
//  CreateMenuViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI
import AVFoundation
import Combine

final class CreateMenuViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var image: UIImage?
    @Published var description: String = ""
    @Published var price: PriceInt = 0
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    @Published var isShowingImagePicker: Bool = false
    @Published var isShowingCameraAlert: Bool = false
    @Published var isSelectingSourceType: Bool = false
    
    @Binding var date: Date
    
    private var scheduleRequest = ScheduleRequest()
    private var menuRequest = MenuRequest()
    private var cancellable = Set<AnyCancellable>()
    
    init(date: Binding<Date>) {
        self._date = date
    }
    
    
    func requestCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
            sourceType = .camera
            isShowingImagePicker = true
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted {
                        self?.sourceType = .camera
                        self?.isShowingImagePicker = true
                    } else {
                        self?.isShowingCameraAlert = true
                    }
                }
            case .denied: // The user has previously denied access.
                isShowingCameraAlert = true

            case .restricted: // The user can't grant access due to restrictions.
                isShowingCameraAlert = true
        @unknown default:
            break
        }
    }
    
    func createMenu(completion: @escaping () -> Void) {
        menuRequest.createMenu(name: name, description: description)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error create menu: \(err.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                guard let menu = data.menu else { return }
                self?.createSchedule(menu_id: menu.id!) {
                    completion()
                }
            }
            .store(in: &cancellable)

    }
    
    func createSchedule(menu_id: Int, completion: @escaping () -> Void) {
        scheduleRequest.createSchedule(date: date.toString(withFormat: "yyyy-MM-dd"), price: price, menu_id: menu_id)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    completion()
                    print("Finished!")
                case .failure(let err):
                    print("Error create schedule: \(err.message!)")
                }
            } receiveValue: { responses in
                guard let data = responses.data else { return }
                print(data)
            }
            .store(in: &cancellable)

    }
}

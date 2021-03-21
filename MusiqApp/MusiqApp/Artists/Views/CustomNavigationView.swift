//
//  CustomNavigationView.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 20/03/2021.
//

import SwiftUI

struct CustomNavigationView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return CustomNavigationView.Coordinator(parent: self)
    }
    
    var view: AnyView
    
    var useLargeTitle: Bool
    var title: String
    var placeholder: String
    
    // onSearch and onCancel closures
    var onSearch: (String) -> ()
    var onCancel: () -> ()
    
    init(view: AnyView,
         useLargeTitle: Bool?,
         title: String,
         placeholder: String?,
         onSearch: @escaping (String) -> (), onCancel: @escaping () -> ()) {
        self.view = view
        self.title = title
        self.placeholder = placeholder ?? "Search"
        self.useLargeTitle = useLargeTitle ?? true
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    // Integrating UIKot navigation controllerwith SwiftUI View...
    func makeUIViewController(context: Context) -> UINavigationController {
        
        let childView = UIHostingController(rootView: view)
        let controller = UINavigationController(rootViewController: childView)
        
        controller.navigationBar.topItem?.title = title
        controller.navigationBar.prefersLargeTitles = useLargeTitle
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = context.coordinator
        
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        controller.navigationBar.topItem?.searchController = searchController
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        uiViewController.navigationBar.topItem?.title = title
        uiViewController.navigationBar.prefersLargeTitles = useLargeTitle
        uiViewController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeholder
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        var parent: CustomNavigationView
        
        init(parent: CustomNavigationView) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.parent.onSearch(searchText)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.parent.onCancel()
        }
    }
}

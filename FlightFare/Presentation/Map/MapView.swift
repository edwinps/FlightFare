//
//  MapView.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var viewModel: MapViewModel
    var coordinator: Coordinator
    
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 2.0
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        @objc func dismiss(_ sender: Any) {
            self.parent.coordinator.dismiss()
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.userTrackingMode = .none
        let region = MKCoordinateRegion(center: viewModel.centerCoordinate,
                                               latitudinalMeters: 10000000,
                                               longitudinalMeters: 10000000)
        mapView.setRegion(region, animated: true)
        addCloseButton(in: mapView, with: context)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        uiView.addAnnotations(viewModel.annotations)
        uiView.addOverlays(viewModel.routePolylines)
    }
}

private extension MapView {
    func addCloseButton(in view: UIView, with context: Context) {
        let dismissButton = UIButton(type: .system)
        dismissButton.setTitle("X", for: .normal)
        dismissButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        dismissButton.setTitleColor(.blue, for: .normal)
        dismissButton.backgroundColor = .white
        dismissButton.layer.cornerRadius = dismissButton.bounds.width / 2
        dismissButton.layer.shadowColor = UIColor.black.cgColor
        dismissButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        dismissButton.layer.shadowOpacity = 0.5
        dismissButton.layer.shadowRadius = 2
        dismissButton.addTarget(context.coordinator,
                                action: #selector(Coordinator.dismiss),
                                for: .touchUpInside)
        view.addSubview(dismissButton)
        
        // Add constraints to position the button at the top-right corner
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dismissButton.widthAnchor.constraint(equalToConstant: 40),
            dismissButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}

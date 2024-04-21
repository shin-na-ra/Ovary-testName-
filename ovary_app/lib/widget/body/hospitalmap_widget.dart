import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:flutter_google_places/flutter_google_places.dart' as loc;
// import 'package:google_api_headers/google_api_headers.dart' as header;
// import 'package:google_maps_webservice/places.dart' as places;

class HospitalMapWidget extends StatefulWidget {
  const HospitalMapWidget({super.key});

  @override
  State<HospitalMapWidget> createState() => _HospitalMapWidgetState();
}

class _HospitalMapWidgetState extends State<HospitalMapWidget> {
  Location location = Location();
  final Map<String, Marker> _markers = {};

  double latitude = 0;
  double longitude = 0;
  GoogleMapController? _controller;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(33.298037, 44.2879251),
    zoom: 10,
  );

  /* search functions--------------------------------------
  Future<void> _handleSearch() async {
    places.Prediction? p = await loc.PlacesAutocomplete.show(
        context: context,
        apiKey: 'your map key,
        onError: onError,// call the onError function below
        mode: loc.Mode.overlay,
        language: 'en',//you can set any language for search
        strictbounds: false,
        types: [],
        decoration: InputDecoration(
            hintText: 'search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: []// you can determine search for just one country
);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(places.PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
  }

  Future<void> displayPrediction(
      places.Prediction p, ScaffoldState? currentState) async {
    places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const header.GoogleApiHeaders().getHeaders());
    places.PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
// detail will get place details that user chose from Prediction search
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    _markers.clear(); //clear old marker and set new one
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15),
        ),
      );
    });
  }
  -------------------------------------------*/
  getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData currentPosition = await location.getLocation();
    latitude = currentPosition.latitude!;
    longitude = currentPosition.longitude!;
    final marker = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(
        title: 'you can add any message here',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children :[Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: double.infinity,
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            markers: _markers.values.toSet(),
            onTap: (LatLng latlng) {
              latitude = latlng.latitude;
              longitude = latlng.longitude;
              final marker = Marker(
                markerId: const MarkerId('myLocation'),
                position: LatLng(latitude, longitude),
                infoWindow: const InfoWindow(
                  title: 'AppLocalizations.of(context).will_deliver_here',
                ),
              );
              setState(() {
                _markers['myLocation'] = marker;
              });
            },
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
        ),
        Positioned(
            left: 10,// you can change place of search bar any where on the map
            child: TextField(
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "장소, 버스, 지하철, 주소 검색",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // searchAndNavigate();
                            }, 
                            iconSize: 30.0,
                          )
                        ),
                        onChanged: (val) {
                          setState(() {
                            // searchAddr = val;
                            // searchCtg = val;
                          }
                        );
                      },
                      onSubmitted: (term) {
                        // searchAndNavigate();
                      },
                    ),
          ),
        ]
      ),
    );
  }

} // end

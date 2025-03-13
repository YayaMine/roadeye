import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'Data_realtime.dart';
import 'Laporan_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6885FE),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            color: Colors.white,
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 60,
              ),
              const SizedBox(width: 5),
              const Text(
                'Road Eye',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6885FE),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/home.png',
                    width: screenWidth * 0.20,
                    height: screenWidth * 0.20,
                  ),
                  const SizedBox(width: 10),
                  const Text('Home')
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/datareal.png',
                    width: screenWidth * 0.20,
                    height: screenWidth * 0.20,
                  ),
                  const SizedBox(width: 10),
                  const Text('Data Realtime')
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/laporan.png',
                    width: screenWidth * 0.20,
                    height: screenWidth * 0.20,
                  ),
                  const SizedBox(width: 10),
                  const Text('Laporan Data')
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LaporanData()),
                );
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/SCREEN AWAL (1).png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Container(
                    height: screenHeight * 0.35,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(37.42796133580664, -122.085749655962),
                        zoom: 14.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point:
                                  LatLng(37.42796133580664, -122.085749655962),
                              builder: (ctx) => const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.18,
                left: 14.0,
                right: 14.0,
                child: Card(
                  color:
                      const Color.fromARGB(255, 250, 250, 250).withOpacity(0.9),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'RoadEye',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF6885FE),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur adipiscing elit.',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF6885FE)),
                        ),
                        const SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6885FE),
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'WELCOME',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.65,
                left: 16.0,
                right: 16.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: _buildCardWithIcon(
                        icon: Icons.addchart_outlined,
                        text: 'LAPORAN DATA',
                        size: screenWidth * 0.4,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LaporanData(), // Navigate to LaporanData
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildCardWithIcon({
    required IconData icon,
    required String text,
    required double size,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SizedBox(
          width: size * 1.0,
          height: size * 1.1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Card(
                  color: Color(0xFF6885FE),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SizedBox(
                    width: size * 0.875,
                    height: size * 0.625,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 40,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

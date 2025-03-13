import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Data_realtime.dart';

class LaporanData extends StatefulWidget {
  const LaporanData({super.key});

  @override
  _LaporanDataState createState() => _LaporanDataState();
}

class _LaporanDataState extends State<LaporanData> {
  late final SupabaseClient supabase;
  late List<Map<String, dynamic>> data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    supabase = Supabase.instance.client;
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await supabase
        .from('RoadEye') // Table name
        .select('*') // Select all fields
        .execute();

    if (response.error == null) {
      setState(() {
        data = List<Map<String, dynamic>>.from(response.data);
        isLoading = false;
      });
    } else {
      // Handle error
      print(response.error!.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6885FE),
        title: const Text('Laporan Data'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final imageUrl = item['image_url'];

                // Ensure latitude and longitude are parsed as double
                final latitude =
                    double.tryParse(item['latitude'].toString()) ?? 0.0;
                final longitude =
                    double.tryParse(item['longitude'].toString()) ?? 0.0;

                final description = item['description'] ??
                    "No description available"; // Handle missing description
                final id = item[
                    'id']; // Assuming you have an 'id' field to uniquely identify each entry

                // Clean the URL to remove unwanted newline characters and trim spaces
                final cleanedUrl =
                    imageUrl?.replaceAll(RegExp(r'[\r\n]'), '').trim();

                // Construct the full URL for the image
                final imageFullUrl =
                    'https://xnaichuqxvxkvrltjohv.supabase.co/storage/v1/object/public/RoadEye/$cleanedUrl';

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Latitude label and value with small data font
                        Text(
                          'Latitude:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold), // Label larger
                        ),
                        Text(
                          '$latitude',
                          style: TextStyle(fontSize: 12), // Smaller data font
                        ),

                        // Longitude label and value with larger label and smaller data font
                        Text(
                          'Longitude:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold), // Label larger
                        ),
                        Text(
                          '$longitude',
                          style: TextStyle(fontSize: 12), // Smaller data font
                        ),
                      ],
                    ),
                    leading: imageUrl != null
                        ? Image.network(imageFullUrl) // Display image
                        : const Icon(Icons.error), // Handle missing image URL
                    // Button to navigate to MapPage with the coordinates
                    trailing: IconButton(
                      icon: const Icon(Icons.map),
                      onPressed: () {
                        // Navigate to MapPage with latitude and longitude
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DataRealtime(
                              latitude: latitude, // Pass latitude
                              longitude: longitude, // Pass longitude
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

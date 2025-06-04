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
    final response = await supabase.from('RoadEye').select('*').execute();
    if (response.error == null) {
      setState(() {
        data = List<Map<String, dynamic>>.from(response.data);
        isLoading = false;
      });
    } else {
      print(response.error!.message);
    }
  }

  void showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
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
                final latitude =
                    double.tryParse(item['latitude'].toString()) ?? 0.0;
                final longitude =
                    double.tryParse(item['longitude'].toString()) ?? 0.0;
                final cleanedUrl =
                    imageUrl?.replaceAll(RegExp(r'[\r\n]'), '').trim();
                final imageFullUrl =
                    'https://xnaichuqxvxkvrltjohv.supabase.co/storage/v1/object/public/RoadEye/$cleanedUrl';

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Latitude:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$latitude',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Text(
                          'Longitude:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$longitude',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    leading: imageUrl != null
                        ? GestureDetector(
                            onTap: () => showImageDialog(imageFullUrl),
                            child: Image.network(
                              imageFullUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.error),
                    trailing: IconButton(
                      icon: const Icon(Icons.map),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DataRealtime(
                              latitude: latitude,
                              longitude: longitude,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuestLeaseScreen extends StatefulWidget {
  final List<String>? paths;
  const GuestLeaseScreen({super.key, this.paths});

  @override
  State<GuestLeaseScreen> createState() => _GuestLeaseScreenState();
}

class _GuestLeaseScreenState extends State<GuestLeaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 48,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        leading: Container(
          height: double.infinity,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 12),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.chevron_left,
              size: 24,
              color: Color(0xFF4B6281),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Hợp đồng thuê nhà',
          style: TextStyle(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF262626),
          ),
        ),
      ),
      body: widget.paths == null || widget.paths!.isEmpty
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Chưa có hình ảnh hợp đồng thuê nhà',
                  style: TextStyle(fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w600),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.paths!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.network(
                    widget.paths![index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('lib/Assets/Rectangle 127.png');
                    },
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BookingScreen extends StatelessWidget {
  final String movieTitle;

  const BookingScreen({super.key, required this.movieTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.white, size: 50),
              ),
              const SizedBox(height: 24),
              const Text(
                'Booking Successful',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'for $movieTitle',
                style: const TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 48),

              // Ticket Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1925&auto=format&fit=crop',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          color: Colors.black,
                          child: const Icon(Icons.confirmation_num,
                              size: 50, color: Colors.white24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTicketInfo('Date', 'April 22'),
                              _buildTicketInfo('Time', '10:40 AM'),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTicketInfo('Cinema', 'M-Park'),
                              _buildTicketInfo('Seats', 'Row 2, B 3, 4'),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Divider(color: Colors.white10),
                          const SizedBox(height: 32),
                          BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: 'BOOKING-8347291',
                            color: Colors.white,
                            height: 60,
                            drawText: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}

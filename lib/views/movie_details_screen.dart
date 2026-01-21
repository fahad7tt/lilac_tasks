// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lilac_tasks/services/movie_service.dart';
import 'package:lilac_tasks/views/booking_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String imdbId;

  const MovieDetailsScreen({super.key, required this.imdbId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  int _selectedDateIndex = 1;
  int _selectedTimeIndex = 1;

  final List<String> _dates = ['12', '13', '14', '15', '16', '17', '18'];
  final List<String> _days = ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'];
  final List<String> _times = [
    '09:40 AM',
    '10:40 AM',
    '11:40 AM',
    '12:40 PM',
    '01:40 PM'
  ];

  @override
  Widget build(BuildContext context) {
    final service = MovieService();

    return Scaffold(
      body: FutureBuilder(
        future: service.fetchMovieDetails(widget.imdbId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Image
                    Stack(
                      children: [
                        Container(
                          height: 400,
                          width: double.infinity,
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.5),
                                Colors.black,
                              ],
                            ),
                          ),
                          child: Image.network(
                            data['Poster'] != 'N/A'
                                ? data['Poster']
                                : 'https://images.unsplash.com/photo-1616530940355-351fabd9524b?q=80&w=1935&auto=format&fit=crop',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Image.network(
                                'https://m.media-amazon.com/images/M/MV5BNGE0YTVjNzUtNzJjOS00NGNlLTgxMzctZTY4YTE1Y2Y1ZTU4XkEyXkFqcGc@._V1_SX300.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.black,
                              child: const Center(
                                child: Icon(Icons.movie,
                                    size: 100, color: Colors.white24),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['Title'],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildBadge(data['Rated']),
                              const SizedBox(width: 8),
                              _buildBadge(data['Genre'].split(',')[0]),
                              const SizedBox(width: 8),
                              _buildBadge(data['Runtime']),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'About The Movie',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data['Plot'],
                            style: const TextStyle(
                                color: Colors.white70, height: 1.5),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Cast',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          _buildCastList(data['Actors']),
                          const SizedBox(height: 32),

                          // Custom Showtime Picker (Dates)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(_dates.length, (index) {
                              bool isSelected = _selectedDateIndex == index;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedDateIndex = index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFFF4B2B)
                                        : Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(_dates[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(_days[index],
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white54)),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),

                          // Custom Showtime Picker (Times)
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(_times.length, (index) {
                              bool isSelected = _selectedTimeIndex == index;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedTimeIndex = index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFFF4B2B)
                                        : Colors.white10,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFFFF4B2B)
                                            : Colors.white10),
                                  ),
                                  child: Text(_times[index],
                                      style: const TextStyle(fontSize: 12)),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Booking Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0), Colors.black],
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookingScreen(movieTitle: data['Title']),
                          ),
                        );
                      },
                      child: const Text('Book Now'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 12, color: Colors.white70)),
    );
  }

  Widget _buildCastList(String actors) {
    final actorList = actors.split(',');
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white10,
                  child: Icon(Icons.person, color: Colors.white24),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60,
                  child: Text(
                    actorList[index].trim(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10, color: Colors.white70),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

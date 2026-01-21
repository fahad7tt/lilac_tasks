import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lilac_tasks/controllers/movie_controller.dart';
import 'package:lilac_tasks/views/profile_screen.dart';
import 'package:lilac_tasks/widgets/movie_card.dart';
import 'package:lilac_tasks/widgets/movie_skeleton.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int _selectedIndex = 0;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MovieController>();

    final List<Widget> _screens = [
      _buildHomeScreen(controller),
      const Center(child: Text('Search Coming Soon')),
      const Center(child: Text('Get ready to save your favorite movies')),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, 0),
            _buildNavItem(Icons.search, 1),
            _buildNavItem(Icons.bookmark, 2),
            _buildNavItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeScreen(MovieController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          Stack(
            children: [
              Container(
                height: 500,
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
                  'https://images.unsplash.com/photo-1616530940355-351fabd9524b?q=80&w=1935&auto=format&fit=crop',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.black,
                    child: const Center(
                      child:
                          Icon(Icons.movie, size: 100, color: Colors.white24),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false)
                              _debounce!.cancel();
                            _debounce =
                                Timer(const Duration(milliseconds: 500), () {
                              if (value.length > 2) {
                                context
                                    .read<MovieController>()
                                    .searchMovies(value);
                              }
                            });
                          },
                          onSubmitted: (value) {
                            context.read<MovieController>().searchMovies(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search movies...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const CircleAvatar(
                      backgroundColor: Colors.white24,
                      child:
                          Icon(Icons.notifications_none, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    const Text(
                      'Spider-Man: No Way Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white24,
                      ),
                      child: const Text('Watch Trailer'),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Trending Section
          _buildSectionHeader('Trending Movie Near You'),
          _buildMovieList(controller.movies),

          // Upcoming Section
          _buildSectionHeader('Upcoming'),
          _buildMovieList(controller.movies.reversed.toList()),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMovieList(List movies) {
    return SizedBox(
      height: 250,
      child: movies.isEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => const MovieSkeleton(),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              },
            ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFFF4B2B) : Colors.white54,
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFFFF4B2B),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

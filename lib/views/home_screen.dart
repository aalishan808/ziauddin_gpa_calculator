import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import the carousel_slider package
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ziauddin_uni_gpa_calculator/ad_helper.dart';
import 'gpa_screen.dart';
import 'cgpa_screen.dart';
import 'degree_cgpa_screen.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of images for the carousel
  final List<String> images = [
    'assets/images/boat.webp', // Add your image paths here
    'assets/images/clifton.webp',
    'assets/images/north.webp',
    'assets/images/sukkur.webp',
  ];

BannerAd? _bannerAd;

void initState() {
  super.initState();
  _bannerAd = BannerAd(
    adUnitId: Adhelper.bannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          _bannerAd = ad as BannerAd;
        });
      },
      onAdFailedToLoad: (ad, error) {
        print("Failed to load a banner ad: ${error.message}");
        ad.dispose();
      },
    ),
  )..load();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo_home.png', // Add your logo in the assets folder
                width: 50,
                height: 50,

              ),
              SizedBox(width: 10),
              Text('Ziauddin Calculator'),
            ],
          ),
        ),
        backgroundColor: Color(0xFF006c2c),
      ),
      body: Stack(
        children:[ Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF006c2c), // Dark shade of primary color
                Color(0xFF4CAF50), // Lighter shade of green
              ],
            ),
          ),
          child: Column(
            children: [
              // Carousel Slider
              SizedBox(height: 20),
              _buildImageSlider(),
              SizedBox(height: 50),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // GPA Calculator Card
                    _buildCalculatorCard(
                      context,
                      icon: Icons.school,
                      title: 'GPA Calculator',
                      subtitle: 'Calculate your semester GPA',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GPAScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                
                    // CGPA Calculator Card
                    _buildCalculatorCard(
                      context,
                      icon: Icons.bar_chart,
                      title: 'CGPA Calculator',
                      subtitle: 'Calculate cumulative GPA',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CGPAScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                
                    // Degree CGPA Calculator Card
                    _buildCalculatorCard(
                      context,
                      icon: Icons.assignment,
                      title: 'BS CGPA Calculator',
                      subtitle: 'Calculate your BS CGPA',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DegreeCGPAScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if(_bannerAd != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          ),
        ]
      ),
    );
  }

  // Carousel Slider Widget
  Widget _buildImageSlider() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200, // Height of the slider
          autoPlay: true, // Auto-play the slider
          enlargeCenterPage: true, // Enlarge the center image
          aspectRatio: 16 / 9, // Aspect ratio of the images
          autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
          enableInfiniteScroll: true, // Infinite scroll
          autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
          viewportFraction: 0.8, // Fraction of the viewport to show
        ),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover, // Adjust the image to fit the box
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  // Custom Card Widget
  Widget _buildCalculatorCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Color(0xFF006c2c),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

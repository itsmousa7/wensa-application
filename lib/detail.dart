import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'images.dart';
import 'main.dart';

class Detailspage extends StatefulWidget {
  final dynamic item; // The item passed from the HomePage

  const Detailspage({required this.item});

  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    // Set images based on the place name from the item
    images = placeImages[widget.item['name']] ?? [];
  }

  String select = 'overview';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Display the first image from the images list or fallback
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35,
            child: images.isNotEmpty
                ? Image.asset(
              images[0],
              fit: BoxFit.cover,
            )
                : Container(color: Colors.grey), // Fallback when no images are present
          ),

          // Back button
          Positioned(
            top: 50,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 21,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 25,
                    color: button,
                  ),
                ),
              ),
            ),
          ),

          // Content starts here
          Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Place name
                    Text(
                      widget.item['name'],
                      style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary, 30),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Location info
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Theme.of(context).colorScheme.tertiary,
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: button,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text("Location", style: AppTextStyles.detailsTextStyle(Theme.of(context).colorScheme.secondary)),
                              Text("${widget.item['location']}", style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary)),
                            ],
                          ),
                          // Opening info
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Theme.of(context).colorScheme.tertiary,
                                child: Icon(
                                  Icons.schedule,
                                  color: button,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text("Open", style: AppTextStyles.detailsTextStyle(Theme.of(context).colorScheme.secondary)),
                              Text("24 Hours", style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary)),
                            ],
                          ),
                          // Distance info
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Theme.of(context).colorScheme.tertiary,
                                child: Icon(
                                  Icons.map,
                                  color: button,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text("Distance", style: AppTextStyles.detailsTextStyle(Theme.of(context).colorScheme.secondary)),
                              Text("600 KM", style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Tab Navigation (Overview, Details, Route)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              select = 'overview';
                            });
                          },
                          child: Column(
                            children: [
                              Text("Overview", style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary, 20)),
                              selectoption(select == 'overview')
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              select = 'details';
                            });
                          },
                          child: Column(
                            children: [
                              Text("Details", style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary, 20)),
                              selectoption(select == 'details')
                            ],
                          ),
                        ),

                      ],
                    ),

                    // Display content based on selected tab
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 16),
                        child: select == 'overview'
                            ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            widget.item['description'],
                            style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary),
                          ),
                        )
                            : select == 'details'
                            ? FanCarouselImageSlider.sliderType2(
                          imagesLink: images,
                          isAssets: true,
                          autoPlay: false,
                          sliderHeight: 250,
                          indicatorActiveColor: balance2,
                          imageRadius: 20,
                          slideViewportFraction: 0.7,
                          expandedCloseBtnDecoration: BoxDecoration(
                              color: background2, borderRadius: BorderRadius.circular(70)),
                          expandedCloseBtn: CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0x99FFFFFF),
                            child: Icon(
                              FontAwesomeIcons.x,
                              color: black,
                              size: 20,
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Route information will be added here.",
                            style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container selectoption(bool select) =>
      Container(color: select ? button : Theme.of(context).colorScheme.background, width: 100, height: 5);
}

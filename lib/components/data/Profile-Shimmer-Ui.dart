import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../editbutton.dart';

class ShimmerProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(222, 224, 224, 224),
      highlightColor: const Color.fromARGB(226, 245, 245, 245),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      radius: 45.0,
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Fullname",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Gender: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Location: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Profession: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Favorite sport: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Phone: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow),
                            const SizedBox(width: 4.0),
                            const Text(
                              "",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: ReusableElevatedButton(
                                onTap: () {},
                                icon: Icons.edit,
                                child: const Text("Edit"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // Add shimmer to other user information fields similarly
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Videos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

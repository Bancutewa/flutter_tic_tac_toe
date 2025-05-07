import 'package:flutter/material.dart';
import 'main.dart'; // Import the TicTacToePage

class HomePage extends StatelessWidget {  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // Use Container for background image or color
      decoration: const BoxDecoration(
        gradient: LinearGradient( // Add a gradient background
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.purpleAccent],
        ),
      ),
      child: Padding( // Add padding around the content
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text( // Add a more prominent title
                'Select Board Size',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40), // Increase spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                builder: (context) => TicTacToePage(boardSize: 3),),
              );
              },
              child: const Text('3x3 Board'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
 builder: (context) => TicTacToePage(boardSize: 4),),
 );
              },
              child: const Text('4x4 Board'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
 builder: (context) => TicTacToePage(boardSize: 5),),
 );
              },
              child: const Text('5x5 Board'),
            ),
          ],
        ),
      ),
    )
    );
  }
}

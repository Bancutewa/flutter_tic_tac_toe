import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart'; // Import the new HomePage

void main() { 
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false, // Start with HomePage
    );
  }
}

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({Key? key, required this.boardSize}) : super(key: key);

  final int boardSize; // Add a parameter for the board size



  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> _board = List.filled(9, '');
  bool _isPlayer1 = true;
  late String _status; // Initialize in initState

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _handleTap(int index) {
    if (_board[index] == '' && _status.contains('turn')) {
      setState(() {
        _board[index] = _isPlayer1 ? 'X' : 'O';
        _isPlayer1 = !_isPlayer1;
        _checkWinner();
      });
    }
  }

  void _initializeBoard() {
    int size = widget.boardSize;
    _board = List.filled(size * size, '');
    _isPlayer1 = true;
    _status = 'Player X\'s turn';
  }

  Future<void> _checkWinner() async {
    int size = widget.boardSize;
    bool winnerFound = false;

    // Check rows
    for (int i = 0; i < size * size; i += size) {
      bool rowWin = true;
      if (_board[i] != '') {
        for (int j = 1; j < size; j++) {
          if (_board[i] != _board[i + j]) {
            rowWin = false;
            break;
          }
        }
        if (rowWin) {
          _endGame(_board[i]);
          winnerFound = true;
          return;
        }
      }
      await Future.delayed(Duration.zero); // Yield to prevent blocking UI
    }

    // Check columns
    for (int i = 0; i < size; i++) {
      bool colWin = true;
      if (_board[i] != '') {
        for (int j = 1; j < size; j++) {
          if (_board[i] != _board[i + j * size]) {
            colWin = false;
            break;
          }
        }
        if (colWin) {
          _endGame(_board[i]);
          winnerFound = true;
          return;
        }
      }
      await Future.delayed(Duration.zero); // Yield to prevent blocking UI
    }

    // Check diagonals
    // Main diagonal
    bool diag1Win = true;
    if (_board[0] != '') {
      for (int i = 1; i < size; i++) {
        if (_board[0] != _board[i * size + i]) {
          diag1Win = false;
          break;
        }
      }
      if (diag1Win) {
        _endGame(_board[0]);
        winnerFound = true;
        return;
      }
    }
    await Future.delayed(Duration.zero); // Yield to prevent blocking UI

    // Anti-diagonal
    bool diag2Win = true;
    if (_board[size - 1] != '') {
      for (int i = 1; i < size; i++) {
        if (_board[size - 1] != _board[i * size + size - 1 - i]) {
          diag2Win = false;
          break;
        }
      }
      if (diag2Win) {
        _endGame(_board[size - 1]);
        winnerFound = true;
        return;
      }
    }
    await Future.delayed(Duration.zero); // Yield to prevent blocking UI

    // Check for draw
    if (!winnerFound && !_board.contains('')) {
      _endGame('Draw');
    } else {
      _status = 'Player ${_isPlayer1 ? 'X' : 'O'}\'s turn';
    }
  }

  void _endGame(String winner) {
    String message;
    if (winner == 'Draw') {
      message = 'It\'s a Draw!';
    } else {
      message = 'Player $winner Wins!';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black, // Classic dialog background
          title: Text(
            'Game Over',
            style: TextStyle(
              color: Colors.greenAccent, // Retro title color
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: Colors.white, // White text for the message
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Reset Game'),
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      int size = widget.boardSize;
      _initializeBoard(); // Use the dedicated function to reset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Classic black background
      appBar: AppBar(
        backgroundColor: Colors.black, // Black app bar
        foregroundColor: Colors.greenAccent, // Retro green text color
        elevation: 0, // No shadow for classic look
        
        centerTitle: true,
      ),
      body: Padding(
        // Removed background styling from body to use Scaffold's backgroundColor
        padding: const EdgeInsets.all(20.0), // Add padding around the body
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _status,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.greenAccent, // Retro green color for status
                  ),// Make status text bold
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.boardSize, // Make crossAxisCount dynamic
                crossAxisSpacing: 4,
                mainAxisSpacing: 4, // Increased spacing
              ),
              itemCount: widget.boardSize * widget.boardSize, // Update itemCount
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 2), // Retro green border
                      color: Colors.black, // Black background for cells
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: TextStyle(
                          fontSize: 60,
                          color: _board[index] == 'X' ? Colors.cyanAccent : Colors.redAccent, // Different retro colors for X and O
                          fontWeight: FontWeight.bold,
                        ), // Increase font size and weight for X and O
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(// Styled reset button
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent, // Retro green button color
                foregroundColor: Colors.black, // Black text color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Add padding
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Increase font size and make text bold
              ),// Add padding
              onPressed: _resetGame, // Add the onPressed callback
              child: const Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}

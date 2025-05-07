# myapp

## Trò chơi Cờ Caro Cơ bản

Dự án này là một triển khai đơn giản của trò chơi Cờ Caro cổ điển sử dụng Flutter.

## Getting Started and Running the Game

1.  **Ensure you have Flutter installed:** If not, follow the instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
2.  **Clone or download the project:** Get the code onto your local machine.
3.  **Open the project in your preferred IDE:** (e.g., VS Code, Android Studio).
4.  **Connect a device or start an emulator:** You can run the game on an Android or iOS device, or use an emulator/simulator.
5.  **Run the app:** From your IDE or the terminal, navigate to the project directory and run:




- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Giải thích Code và Luồng chạy

Đây là một ứng dụng trò chơi Cờ Caro được phát triển bằng Flutter, cho phép người chơi chọn kích thước bàn cờ và thi đấu với nhau. Giao diện của trò chơi được thiết kế theo phong cách cổ điển.

### Cấu trúc Code

Ứng dụng bao gồm hai phần chính:

1.  **`HomePage` (`lib/home_page.dart`):**
    *   Đây là màn hình đầu tiên khi bạn mở ứng dụng.
    *   Nó hiển thị các nút cho phép người chơi chọn kích thước bàn cờ (3x3, 4x4, 5x5).
    *   Khi người chơi nhấn vào một nút, ứng dụng sẽ điều hướng đến `TicTacToePage`, truyền kích thước bàn cờ đã chọn.
    *   Giao diện của trang này được thiết kế đơn giản và trực quan để người dùng dễ dàng chọn lựa, đồng thời mang một chút phong cách game.

2.  **`TicTacToePage` (`lib/main.dart`):**
    *   Đây là màn hình chính của trò chơi, nơi diễn ra ván đấu Cờ Caro.
    *   Widget này nhận kích thước bàn cờ (`boardSize`) từ `HomePage`.
    *   **Logic Game:**
        *   **Bàn cờ:** Được biểu diễn bằng một danh sách (`List`) lưu trữ trạng thái của mỗi ô (trống, 'X', hoặc 'O'). Kích thước của danh sách này được tính toán dựa trên `boardSize` (`boardSize * boardSize`).
        *   **Lượt chơi:** Sử dụng một biến boolean (`_isPlayer1`) để theo dõi lượt của người chơi hiện tại ('X' hoặc 'O').
        *   **Xử lý chạm:** Hàm `_handleTap` được gọi khi người chơi chạm vào một ô trên bàn cờ. Nó kiểm tra xem ô đó có trống không và cập nhật trạng thái của ô bằng ký hiệu của người chơi hiện tại, sau đó chuyển lượt.
        *   **Kiểm tra thắng/hòa:** Hàm `_checkWinner` được gọi sau mỗi nước đi. Nó kiểm tra các hàng, cột và đường chéo để xác định xem có người thắng cuộc chưa.
            *   Logic kiểm tra thắng được xây dựng để hoạt động với bất kỳ kích thước bàn cờ nào bằng cách sử dụng `boardSize` để tính toán chỉ số và điều kiện lặp.
            *   Nếu không có người thắng và tất cả các ô đều đầy, trò chơi sẽ kết thúc với kết quả hòa.
            *   Các thao tác kiểm tra được làm bất đồng bộ một chút (`await Future.delayed(Duration.zero)`) để tránh làm đơ giao diện với các bàn cờ lớn.
        *   **Kết thúc game:** Hàm `_endGame` hiển thị một AlertDialog thông báo người thắng cuộc hoặc kết quả hòa, và cung cấp nút để chơi lại. Giao diện của AlertDialog này cũng được tùy chỉnh theo phong cách cổ điển.
        *   **Chơi lại:** Hàm `_resetGame` đặt lại trạng thái bàn cờ và các biến về trạng thái ban đầu để bắt đầu ván mới.
    *   **Giao diện (UI):**
        *   Bàn cờ được xây dựng bằng `GridView.builder`, cho phép tạo ra một lưới các ô (biểu thị bằng `GestureDetector` và `Container`) dựa trên `boardSize`.
        *   Mỗi ô hiển thị ký hiệu 'X' hoặc 'O' (hoặc trống).
        *   Giao diện được thiết kế theo phong cách cổ điển để mang lại cảm giác retro.
        *   Hiển thị trạng thái hiện tại của trò chơi (ví dụ: "Lượt của người chơi X").

### Luồng chạy của Code

1.  Ứng dụng bắt đầu tại hàm `main()` trong `lib/main.dart`, chạy widget `MyApp`.
2.  `MyApp` thiết lập các cài đặt cơ bản của ứng dụng (chủ đề) và đặt `HomePage` làm màn hình chính ban đầu.
3.  Trên `HomePage`, người dùng chọn kích thước bàn cờ bằng cách nhấn nút.
4.  Sự kiện `onPressed` của nút được nhấn sẽ đẩy `TicTacToePage` lên trên stack màn hình, truyền giá trị `boardSize` đã chọn qua constructor.
5.  `TicTacToePage` được khởi tạo với kích thước bàn cờ, tạo ra bàn cờ trống và thiết lập trạng thái ban đầu.
6.  Người chơi chạm vào các ô trên bàn cờ.
7.  Hàm `_handleTap` xử lý nước đi, cập nhật trạng thái bàn cờ và chuyển lượt.
8.  Sau mỗi nước đi, hàm `_checkWinner` kiểm tra kết quả.
9.  Nếu có người thắng hoặc hòa, `_endGame` hiển thị thông báo và tùy chọn chơi lại.
10. Nhấn "Reset Game" gọi `_resetGame` để bắt đầu ván mới.

## Giao diện Cổ điển

Cả màn hình chọn kích thước bàn cờ (`HomePage`) và màn hình chơi game (`TicTacToePage`), bao gồm cả thông báo kết thúc game, đều được tùy chỉnh giao diện để mang phong cách cổ điển, đơn giản và dễ nhìn, tạo cảm giác như một trò chơi retro.

## Cách chạy ứng dụng

Vui lòng tham khảo phần "Getting Started and Running the Game" ở đầu file README này.

Chúc bạn chơi game vui vẻ!

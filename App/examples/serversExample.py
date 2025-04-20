import socket
import threading
import signal
import sys
from flask import Flask, send_file


def get_local_ip():
    """Funkcja do uzyskania lokalnego adresu IP"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80)) # Google DNS server
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        return "127.0.0.1"

def tcp_server():
    """Serwer TCP do odbierania danych od klienta"""
    local_ip = get_local_ip()
    port = 1234

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', port))
    server_socket.listen(1)

    print(f"**Serwer TCP nasłuchuje na {local_ip}:{port}**")

    client_socket, client_address = server_socket.accept()
    print(f"Połączono z {client_address}")

    while True:
        data = client_socket.recv(1024)
        if not data:
            break
        print(f"Otrzymano: {data.decode()}")

    client_socket.close()
    server_socket.close()

def http_server():
    """Serwer HTTP do przesyłania pliku wideo"""
    app = Flask(__name__)
    local_ip = get_local_ip()
    port = 8080

    @app.route('/stream.mp4')
    def stream_mp4():
        """Funkcja do przesyłania pliku wideo video.mp4"""
        return send_file("video.mp4", mimetype='video/mp4')

    print(f"**Serwer HTTP uruchomiony na http://{local_ip}:{port}/stream.mp4**")
    app.run(host='0.0.0.0', port=port)

def signal_handler(sig, frame):
    print("\nZatrzymywanie programu...")
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

try:
    tcp_thread = threading.Thread(target=tcp_server, daemon=True)
    tcp_thread.start()
    http_server()
except KeyboardInterrupt:
    pass
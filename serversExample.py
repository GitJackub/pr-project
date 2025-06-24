import socket
import threading
import signal
import sys
from flask import Flask, send_file, Response

from picamera2 import Picamera2
from picamera2.encoders import MJPEGEncoder
from picamera2.outputs import FileOutput
from io import BytesIO
import time
import cv2

import RPi.GPIO as GPIO


# Piny PWM (EN) – BCM
pwm_pins = [27, 22, 5, 6]  # UWAGA: GPIO 33 i 32 są niedostępne na Pi Zero! Patrz poniżej.
# Piny kierunku
dir_pins = [23,24, 25, 8]

# Konfiguracja GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# Ustawienie pinów kierunku
for pin in dir_pins:
    GPIO.setup(pin, GPIO.OUT)
    GPIO.output(pin, GPIO.LOW)

# Ustawienie pinów PWM
pwms = []
for pin in pwm_pins:
    GPIO.setup(pin, GPIO.OUT)
    pwm = GPIO.PWM(pin, 1000)  # częstotliwość 1 kHz
    pwm.start(0)
    pwms.append(pwm)

def move_forward_backward(speed, forward):
    GPIO.output(dir_pins[0], GPIO.HIGH if forward else GPIO.LOW)
    GPIO.output(dir_pins[1], GPIO.HIGH if forward else GPIO.LOW)
    GPIO.output(dir_pins[2], GPIO.LOW if forward else GPIO.HIGH)
    GPIO.output(dir_pins[3], GPIO.LOW if forward else GPIO.HIGH)
    print("Server ")
    for pwm in pwms:
        pwm.ChangeDutyCycle(speed * 100 / 255)

def rotate_right_left(speed, right):
    GPIO.output(dir_pins[0], GPIO.HIGH if right else GPIO.LOW)
    GPIO.output(dir_pins[1], GPIO.LOW if right else GPIO.HIGH)
    GPIO.output(dir_pins[2], GPIO.LOW if right else GPIO.HIGH)
    GPIO.output(dir_pins[3], GPIO.HIGH if right else GPIO.LOW)
    for pwm in pwms:
        pwm.ChangeDutyCycle(speed * 100 / 255)

def standby():
    for pin in dir_pins:
        GPIO.output(pin, GPIO.LOW)

#SERVO_PIN = 26

#GPIO.setmode(GPIO.BCM)
#GPIO.setup(SERVO_PIN, GPIO.OUT)
#servo_pwm = GPIO.PWM(SERVO_PIN, 50)
#servo_pwm.start(0)

#def set_servo_angle(angle):
    
   # duty_cycle = (angle / 18) +2
   # servo_pwm.ChangeDutyCycle(duty_cycle)
   # time.sleep(1)
    
    
  



def get_local_ip():
    
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80)) # Google DNS server
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        return "127.0.0.1"

def tcp_server():
    """TCP Server"""
    local_ip = get_local_ip()
    port = 1234

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', port))
    server_socket.listen(1)

    print(f"**Server TCP listening on {local_ip}:{port}**")

    client_socket, client_address = server_socket.accept()
    print(f"Connected to {client_address}")
    
    angle = 90
    try:
        while True:
            data = client_socket.recv(1024)
            if not data:
                break
            
            try:
                info = data.decode().strip()
                
                print(f"Received: {info}")
                
                if info == "1":
                    angle = angle + 2
                   # set_servo_angle(angle)
                elif info == "2":
                    angle = angle -2 
                  #  set_servo_angle(angle)
                elif info == "3":
                    move_forward_backward(180,True)
                elif info == "4":
                    move_forward_backward(180,False)
                elif info == "5":
                    rotate_right_left(180,True)
                elif info == "6":
                    rotate_right_left(180,False)
                elif info == "0":
                    standby()
                else:
                    print("Unknown command")
            except:
                print("Did not received data")
    finally:
       # client_socket.close()
       # server_socket.close()
        #servo_pwm.stop()
        #GPIO.cleanup()
       # for pwm in pwms:
          #  pwm.stop()
            print("Connection closed")

picam2 = Picamera2()
picam2.configure(picam2.create_video_configuration(main={"size": (640, 480)}))
picam2.start()

def generate_frames():
    while True:
        frame = picam2.capture_array()
        ret, jpeg = cv2.imencode('.jpg', frame)
        if not ret:
            continue
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + jpeg.tobytes() + b'\r\n')
def http_server():
    app = Flask(__name__)
    local_ip = get_local_ip()
    port = 8080


    @app.route('/video_feed')
    def video_feed():
        return Response(generate_frames(),
                        mimetype='multipart/x-mixed-replace; boundary=frame')

    print(f"**HTTP Server launched on http://{local_ip}:{port}/stream.mp4**")
    app.run(host='0.0.0.0', port=port)

def signal_handler(sig, frame):
    print("\nStopping program...")
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

try:
    tcp_thread = threading.Thread(target=tcp_server, daemon=True)
    tcp_thread.start()
    http_server()
except KeyboardInterrupt:
    pass
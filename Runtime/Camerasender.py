from flask import Flask
import cv2
import time
import threading
import pythoncom
import socket
from pygrabber.dshow_graph import FilterGraph
from colorama import init, Fore, Back, Style
import json


init()

app = Flask(__name__)

settings = r".\Settings.json"
with open(settings, "r", encoding="utf-8") as file:
    data = json.load(file)

FPS = data["FPS"]
WIDTH, HEIGHT = data["WIDTH"], data["HEIGHT"]

latest = ""


def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return "127.0.0.1"


def find_obs_camera():
    pythoncom.CoInitialize()

    graph = FilterGraph()
    devices = graph.get_input_devices()

    print("[INFO] Available cameras:")
    for i, name in enumerate(devices):
        print(f"  {i}: {name}")

    while True:
        try:
            inp = input("Choose a camera by index: ").strip()

            if inp == "":
                print("[ERROR] Enter a number")
                continue

            idx = int(inp)

            if idx < 0 or idx >= len(devices):
                print("[ERROR] Invalid index")
                continue

            return idx

        except ValueError:
            print("[ERROR] Invalid input")


def capture_loop(cam_index):
    global latest

    cap = cv2.VideoCapture(cam_index, cv2.CAP_DSHOW)

    if not cap.isOpened():
        print("[ERROR] Could not open camera")
        return

    while True:
        ret, frame = cap.read()
        if not ret:
            continue

        frame = cv2.resize(frame, (WIDTH, HEIGHT))

        rows = []
        for y in range(HEIGHT):
            row = []
            for x in range(WIDTH):
                b, g, r = frame[y][x]
                row.append(f"{r},{g},{b}")
            rows.append(";".join(row))

        latest = "|".join(rows)

        time.sleep(1 / FPS)


@app.route("/")
def get():
    return latest


if __name__ == "__main__":
    cam_index = find_obs_camera()

    threading.Thread(
        target=capture_loop,
        args=(cam_index,),
        daemon=True
    ).start()

    local_ip = get_local_ip()

    print("\n==============================")
    print(
        Back.LIGHTBLUE_EX +
        Fore.WHITE +
        f" USE THIS URI: http://{local_ip}:5000 " +
        Style.RESET_ALL
    )
    print("==============================\n")

    app.run(host="0.0.0.0", port=5000, threaded=True)
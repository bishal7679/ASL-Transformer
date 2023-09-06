

# Transforming ASL to sign Language animation ☀️
---
![rancher-asl-final](https://github.com/bishal7679/ASL-Transformer/assets/70086051/45739c7a-07b4-474f-a46c-fd1edb2ff617)

This is an interactive Machine Learning Web App "ASL-Transformer" developed using Python. It will help the deaf persons to understand sign language through animation from audio or Transcripted Test

![04-09-2023:22:09:04](https://github.com/bishal7679/ASL-Transformer/assets/70086051/86f1f9bf-037b-4223-a30f-d24abde7583e)

# Project Overview 🤯
  - This program has three main steps:
      
    - Convert audio to text (skipped when converting text-to-sign)
          
    - Find what movement corresponds to each word
          
    - Animate the movement
   
    This system has the capability to accept two distinct types of input: audio files and text. When an audio file is provided, it transforms the spoken words within the audio into a transcript. Conversely, if text input is supplied, the system takes a different route by generating an animation that conveys the transcript in sign language before proceeding to the subsequent stage. In cases where text input is utilized, the usual process is bypassed, and the program directly generates an animation of the text represented in sign language. Beyond serving as a valuable tool for creating sign language equivalents of closed captions, this system has a broader educational utility. It caters to individuals interested in learning sign language, allowing them to self-educate by practicing various phrases using both the speech-to-sign and text-to-sign functionalities provided by SpeechToSign.

# Tech Stack used 🧪
  * OpenAI's Whisper API to convert speech to text
  * Using Python scripts to convert the .txt file into a list of unique strings
  * Using Flask for Frontend
  * Using Google's MediaPipe Hand Landmarker to retry the coordinates of each hand
  * Using the ASL Dictionary to map each word to an array of coordinates
  * Using three.js to animate the set of points
  * Using HTML, CSS, JS, and Git to create a website and repository
  * Using Rancher, k3s, k8s, AWS ECS Cluster for Deployment
  * Github Action for CI/CD pipeline

      ![Abstract letter N modern logo icon design concept](https://github.com/bishal7679/ASL-Transformer/assets/70086051/a47ba5df-a099-4cf1-a88f-baafe9c9f921)

# Challenges ✨
  * Semantics: Not having the exact translation of every word in the ASL dictionary
  * Creating a model that uses both right and left hand, especially when their animations overlap
  * Making User Interface design smooth, accommodating both text and audio file inputs

# Technical Overview 🚀
  * Collect all the videos from ASL dictionary for the required words spoken in the audio file.
  * Load the model from whisper to convert the given audio to Transcripted words and then modify those words so all of them are in the dictionary and save them to a list.
  * Make a POST request to submit the ASL words and convert it to sign language animation.
  * Determine handedness based on hand landmarker positions and store the coordinates and joint index to reference.json
  * Display the video frame with landmarker through OpenCV
  * Containerize the application.
  * Define a deployment mechanism (such as with yaml manifest files).
  * Deploy the application (Kubernetes).

# How-to setup Locally 💻
  * Requirements:
    * System: Python (3.11.4)
    * Speech-to-text: PyTorch, ffmpeg (6.0), openai-whisper (beta)
    * Animation: NumPy (1.21.0), mediapipe (0.8.9.1)
    * Misc: Flask, Levenstein (0.2.1), regex (2023.6.3), opencv-python (4.5.5.61)

  * Instructions:

    * Clone the repository
        ```ruby
          git clone https://github.com/bishal7679/ASL-Transformer.git
  
        ```
    * Set up Python virtual environment
        ```ruby
          python -m venv myenv

        ```
    * Install required dependencies (`requirements.txt`)
    * Run the app.py file
        ```ruby
          python app.py
        ```

# How-to Deployment 🏭
  * Create the `Dockerfile` first
    ```ruby
      FROM python:3.9-slim-buster
      WORKDIR /app
      COPY . /app
      WORKDIR /app
      ADD ./requirements.txt ./requirements.txt
      RUN pip install -r requirements.txt
      EXPOSE 5000
      ENV FLASK_APP=app.py
      CMD ["flask", "run", "--host", "0.0.0.0"]
    ```


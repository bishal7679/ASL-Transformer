

# Transforming ASL to sign Language animation ☀️
---
![rancher-asl-final](https://github.com/bishal7679/ASL-Transformer/assets/70086051/45739c7a-07b4-474f-a46c-fd1edb2ff617)

This is an interactive Machine Learning Web App "ASL-Transformer" developed using Python. It will help the deaf persons to understand sign language through animation from audio or Transcripted Test.

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
  * ### Containerization 🐳
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
      The Dockerfile tells the docker build command to:
  
        - start with the 'python:3.9-slim-buster' base image.
        
        - Set the working directory of container space and the copy the contents of the current directory (where the command is issued) to the '/app' directory in the image itself.
        
        - use '/app' as the working directory for subsequent instructions.
        
        - add `requirements.txt` to /app & install the Python packages as per the 'requirements.txt' file created earlier. (Avoid cache purge by adding requirements first)
        
        - expose the container port 5000
        
        - run the 'app.py' script.
     
    * Build the Docker image
        ```ruby
        docker build -t asl-transformer:latest .
        ```

    * Tag the image to your Docker Hub account.
        ```ruby
        docker tag asl-transformer:latest <USERNAME>/asl-transformer:latest
        ```
        Replace <USERNAME> with your Docker Hub user name.

    * Then Push the image to your Docker Hub account.

       - This will make it easier to deploy to your Kubernetes cluster.
        ```ruby
        sudo docker push <USERNAME>/asl-transformer:latest
        ```
        > **Note**:- make sure to `docker login` first to push the image
    * Run the container.
        ```ruby
        docker run -p 5000:5000 asl-transformer:latest
        ```
        Open your Web browser to `http://localhost:5000/` and verify that you can access the application.

  * ### kubernetes manifests ☸
    * Go to the /kubernetes folder and apply two manifests (make sure to install kubectl)
      - `namespace.yaml`
      - `deployment.yaml`
      - `service.yaml`
    * Create a namespace named "healthcare"
      ```ruby
      kubectl apply -f namespace.yaml
      ```
      ```ruby
      kubectl apply -f deployment.yaml
      ```
      ```ruby
      kubectl apply -f service.yaml
      ```

    * Check whether all the pods are running in the `healthcare` namespace.
      ```ruby
      kubectl get pods -n healthcare
      ```
      - Result:- 
      ```ruby
      NAME                              READY   STATUS    RESTARTS   AGE
      asl-transformer-5df6b686c-dt69m   1/1     Running   0          9m31s
      asl-transformer-5df6b686c-pv288   1/1     Running   0          9m31s
      ```
      ![08-09-2023:00:03:58](https://github.com/bishal7679/ASL-Transformer/assets/70086051/5b2caf00-87cc-401b-b459-c76f69342234)

    * Get all the information of the running resources `healthcare` namespace.
      ```ruby
      kubectl get all -n healthcare
      ```
      
      ```ruby
      NAME                                  READY   STATUS    RESTARTS   AGE
      pod/asl-transformer-5df6b686c-dt69m   1/1     Running   0          18m
      pod/asl-transformer-5df6b686c-pv288   1/1     Running   0          6d
      
      NAME                               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
      service/asl-transformer            ClusterIP   10.43.192.253   <none>        5000/TCP         6d1h
      service/asl-transformer-nodeport   NodePort    10.43.45.17     <none>        5000:30002/TCP   6d1h
      service/kubernetes                 ClusterIP   10.43.0.1       <none>        443/TCP          123d
      
      NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
      deployment.apps/asl-transformer   2/2     2            2           6d1h
      
      NAME                                         DESIRED   CURRENT   READY   AGE
      replicaset.apps/asl-transformer-5df6b686c    2         2         2       6d
      ```
      ![08-09-2023:00:17:49](https://github.com/bishal7679/ASL-Transformer/assets/70086051/3990f106-550b-4f25-a7f8-2b8b14dd5807)


      

  


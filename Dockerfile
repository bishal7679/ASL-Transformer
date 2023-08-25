FROM python:3.9-slim-buster

# add user (change to whatever you want)
# prevents running sudo commands
RUN useradd -r -s /bin/bash bishal

# set current env
ENV HOME /app
WORKDIR /app
ENV PATH="/app/.local/bin:${PATH}"

RUN chown -R bishal:bishal /app
USER bishal

# set up config option
ENV FLASK_ENV=production

# Avoid cache purge by adding requirements first
ADD ./requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r ./requirements.txt --user

# Add rest of the files
COPY . /app

WORKDIR /app

# start web server
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app", "--workers=5"]
FROM nginx:latest

# add our own html file to the image...
COPY web /usr/share/nginx/html

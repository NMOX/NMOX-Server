FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# Create a basic HTML page
RUN echo '<!DOCTYPE html>\n\
<html>\n\
<head>\n\
    <title>NMOX - New Media On X</title>\n\
</head>\n\
<body>\n\
    <h1>Welcome to NMOX</h1>\n\
    <p>A Meta-Framework building on a central X object across languages.</p>\n\
</body>\n\
</html>' > index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

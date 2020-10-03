# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/CHANGELOG.md for
# a list of version numbers.
FROM phusion/passenger-nodejs:1.0.11

# Set correct environment variables.
ENV HOME /root

# Nginx and Passenger are disabled by default. Enable them like so:
RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default

# Create app directory
RUN mkdir -p /home/app
WORKDIR /home/app

# ...put your own build instructions here...
EXPOSE 3000

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# CMD [ "npm", "start" ]

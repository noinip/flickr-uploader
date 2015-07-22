# Set base os
FROM phusion/baseimage:0.9.16

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Set volume
VOLUME /photos 
VOLUME /folders2flickr

# Start script
ADD config.sh /etc/my_init.d/config.sh
RUN chmod +x /etc/my_init.d/config.sh && \

# Set the locale
locale-gen en_US.UTF-8 && \

# Fix a Debianism of the nobody's uid being 65534
usermod -u 99 nobody && \
usermod -g 100 nobody && \


# Install python
apt-get update && \
apt-get -y --force-yes install python-pip python-dev build-essential && \
pip install --upgrade pip && \
pip install --upgrade virtualenv && \
apt-get -y --force-yes install git && \

# Install folders2flickr
pip install --user git+https://github.com/richq/folders2flickr.git && \
cp /root/.local/share/folders2flickr/uploadr.ini.sample /root/.uploadr.ini && \

# Set start file
mv /root/.local/bin/folders2flickr /etc/my_init.d/folders2flickr && \
chmod +x /etc/my_init.d/folders2flickr && \

# Clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))

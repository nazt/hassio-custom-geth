# ARG BUILD_FROM
# FROM $BUILD_FROM

# # Set shell
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# COPY rootfs /

# RUN apk add --no-cache  \
#         openssh autossh nginx

# # RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""

# # COPY run.sh /
# # RUN chmod a+x /run.sh

# # CMD [ "/run.sh" ]


# Use the official Geth image as a parent image
FROM ethereum/client-go:latest

# Install bashio and other dependencies, if needed
# Here, you'd need to know the base distribution. If it's Alpine Linux, use apk. 
# If it's Debian-based, use apt-get. This is a hypothetical example.
# RUN apk add --no-cache bashio autossh

COPY rootfs /
# Copy the run.sh script into the container
COPY run.sh /run.sh

# Ensure the script is executable
RUN chmod +x /run.sh

# Run the script when the container launches
CMD ["/run.sh"]

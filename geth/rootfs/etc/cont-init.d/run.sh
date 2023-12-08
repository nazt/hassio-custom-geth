#!/usr/bin/env bashio
set -e

declare remote_string
# https://github.com/hassio-addons/bashio

bashio::log.info "Public key:"

mkdir -p /root/.ssh
cp -Rv /ssl/.ssh/archtomation_rsa /root/.ssh/id_rsa
cp -Rv /ssl/.ssh/archtomation_rsa.pub /root/.ssh/id_rsa.pub

TUNNEL_HOST=$(bashio::config 'tunnel_host')
TUNNEL_USER=device
# TUNNEL_PORT=55001
MONITOR_PORT=20000
KEY_PATH=/root/.ssh/id_rsa
# TUNNEL_REMOTE_STRING=$(bashio::config 'tunnel_remote_string')


echo "#!/usr/bin/env bashio" > /tmp/go.sh
# echo "AUTOSSH_DEBUG=1 autossh" "$DAEMON_ARGS" >> go.sh

# Set username and password for the broker
for remote in $(bashio::config 'tunnel_remotes|keys'); do
#   bashio::log.info "Remote: ${remote}"
  bashio::log.info "tunnel_remotes[${remote}].remote_string"
#   bashio::config.require.remote_string "tunnel_remotes[${remote}].remote_string"
#   bashio::config.require.password "tunnel_remotes[${remote}].password"
  TUNNEL_REMOTE_STRING=$(bashio::config "tunnel_remotes[${remote}].remote_string")
#   password=$(bashio::config "tunnel_remotes[${remote}].password")

  bashio::log.info "${TUNNEL_REMOTE_STRING}"
  AUTOSSH_ARGS="-M $MONITOR_PORT "
  SSH_ARGS="-nNTv -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -i $KEY_PATH -R $TUNNEL_REMOTE_STRING $TUNNEL_USER@$TUNNEL_HOST"
  DAEMON_ARGS=" $AUTOSSH_ARGS $SSH_ARGS"
  echo "AUTOSSH_GATETIME=0 AUTOSSH_DEBUG=1 autossh" "$DAEMON_ARGS" "&" >> /tmp/go.sh
  echo "sleep 9" >> /tmp/go.sh
#   password=$(np -p "${password}")
#   echo "${username}:${password}" >> "${PW}"
#   echo "user ${username}" >> "${ACL}"
done


echo "Ready to go.sh"
cat /tmp/go.sh
chmod +x /tmp/go.sh
# ./go.sh

# bashio::log.info "Starting NGinx server..."
# nginx

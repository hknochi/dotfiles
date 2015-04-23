# Path expansion
export PATH=$HOME/.bin:$PATH # add user binaries to path
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# export docker host address
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Java home
export JAVA_HOME="$(/usr/libexec/java_home)"

# Docker Config
export ECC_DOCKER='d --tlsverify --tlscacert=$HOME/.config/ssl/docker-eccenca/ca.pem --tlscert=$HOME/.config/ssl/docker-eccenca/client-cert.pem --tlskey=$HOME/.config/ssl/docker-eccenca/client-key.pem '
export ECC_DOCKER_PORT='2375'
export PRVT_DOCKER='d --tlsverify --tlscacert=$HOME/.config/ssl/pki-hknochi/ca/docker-ca.cer --tlscert=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi.crt --tlskey=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi-rsa.key'
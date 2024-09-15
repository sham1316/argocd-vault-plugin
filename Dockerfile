FROM alpine:3.20.2 

# Switch to root for the ability to perform install
USER root

RUN apk add curl gpg && \
    rm /var/cache/apk/* 

# Install the AVP plugin (as root so we can copy to /usr/local/bin)
ARG AVP_VERSION=1.18.1

ENV AVP_VERSION=$AVP_VERSION
ENV BIN=argocd-vault-plugin
RUN curl -L -o ${BIN} https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64
RUN chmod +x ${BIN}
RUN mv ${BIN} /usr/local/bin

# Switch back to non-root user
USER 999
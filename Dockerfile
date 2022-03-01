ARG DEBIAN_IMAGE_VERSION="bullseye-slim"
FROM debian:${DEBIAN_IMAGE_VERSION}

ARG JDK_VERSION="11"
ARG GRAALVM_VERSION="22.0.0.2"
ARG VCS_REF
ARG VCS_URL
ARG BUILD_DATE

LABEL maintainer="Ramses Vidor <ramsvidor@gmail.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      com.ramsesvidor.license="Apache-2.0"

ENV LANG="C.UTF-8" \
    JAVA_HOME="/usr/lib/java/graalvm-ce-java${JDK_VERSION}-${GRAALVM_VERSION}"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN apt-get -qq update && apt-get -qq install --no-install-recommends wget ca-certificates p11-kit && apt-get -qq autoremove --purge; \
    mkdir -m 755 -p "/usr/lib/java"; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*; \
    wget -qO- "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java${JDK_VERSION}-linux-amd64-${GRAALVM_VERSION}.tar.gz" \
        | tar xfz - -C "/usr/lib/java"

CMD "/bin/bash"

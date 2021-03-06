ARG BASE_IMAGE=senzing/senzing-base:1.2.1
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-09-01

LABEL Name="senzing/python-demo" \
      Maintainer="support@senzing.com" \
      Version="1.2.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages via PIP.

RUN pip3 install \
    Flask==1.0.2

# The port for the Flask is 5000.

EXPOSE 5000

# Copy files from repository.

COPY ./rootfs /

# Make non-root container.

USER 1001

# Runtime execution.

ENV FLASK_APP=/app/app.py

WORKDIR /app
CMD ["flask", "run", "--host=0.0.0.0"]

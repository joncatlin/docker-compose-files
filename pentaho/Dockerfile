# Use the prebuilt image with ubuntu desktop install and configured
FROM bretif/pentaho:8.2

USER root

# Make the directories used for testing the ETL jobs and create volume mountpoints
# so they can be mapped to external directories
RUN mkdir /input /output /processed \
    && chown pentaho:pentaho /input /output /processed

USER pentaho

VOLUME ["/input", "/processed", "/output" ]

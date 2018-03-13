FROM java:8-jdk-alpine
VOLUME /tmp
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
COPY app.jar app.jar
ENTRYPOINT ["./entrypoint.sh"]
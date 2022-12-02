FROM debian:11

# It's A Me!
LABEL maintainer "Rian Katoen <riankatoen@gmail.com>"

# Install dependencies
RUN  apt-get update \
  && apt-get install -y wget libdigest-sha-perl \
  && rm -rf /var/lib/apt/lists/*

# Make user to run the stuff
RUN groupadd -r runner && useradd -r -g runner runner
# Create a folder
RUN mkdir /actions-runner
RUN chown runner /actions-runner 
RUN chmod -R 775 /actions-runner
WORKDIR /actions-runner
# Switch to runner user
USER runner
# Download the latest runner package
RUN wget -q -O actions-runner-linux-x64-2.299.1.tar.gz https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz
# Optional: Validate the hash
RUN echo "147c14700c6cb997421b9a239c012197f11ea9854cd901ee88ead6fe73a72c74  actions-runner-linux-x64-2.299.1.tar.gz" | shasum -a 256 -c
# Extract the installer
RUN tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz
# Install dependencies
USER root
RUN ./bin/installdependencies.sh
USER runner
COPY start-runner.sh /actions-runner
# Create the runner and start the configuration experience
# Last step, run it!
# Let's A Go!
ENTRYPOINT ["./start-runner.sh"]
CMD [""]
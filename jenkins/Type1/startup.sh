#!/bin/bash

# Wait for Jenkins to be fully up (adjust the sleep time as needed)
sleep 60

# Run the specified command after Jenkins is ready
curl -sO http://172.19.0.1:8080/jnlpJars/agent.jar

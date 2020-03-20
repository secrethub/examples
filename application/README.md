# Example applications
This folder contains the examples for the web application frameworks. The basic structure of all the examples is as followed:
1. Init the SecretHub demo repository
2. Create a service account on the demo repository
3. Build the docker file
4. Run the docker file
5. Check if the example works with a curl on localhost:8080. The example returns code 200 if successful and 500 otherwise
```
curl -i localhost:8080
```

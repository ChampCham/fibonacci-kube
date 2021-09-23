docker build -t champchamchamp/multi-client:latest -t champchamchamp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t champchamchamp/multi-server:latest -t champchamchamp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t champchamchamp/multi-worker:latest -t champchamchamp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push champchamchamp/multi-client:latest
docker push champchamchamp/multi-server:latest
docker push champchamchamp/multi-worker:latest

docker push champchamchamp/multi-client:$SHA
docker push champchamchamp/multi-server:$SHA
docker push champchamchamp/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/client-deployment client=champchamchamp/multi-client:$SHA  
kubectl set image deployments/server-deployment server=champchamchamp/multi-server:$SHA  
kubectl set image deployments/worker-deployment worker=champchamchamp/multi-worker:$SHA  
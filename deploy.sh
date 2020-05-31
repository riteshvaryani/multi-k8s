docker build -t riteshvaryani/multi-client:latest -t riteshvaryani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t riteshvaryani/multi-server:latest -t riteshvaryani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t riteshvaryani/multi-worker:latest -t riteshvaryani/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push riteshvaryani/multi-client:latest
docker push riteshvaryani/multi-server:latest
docker push riteshvaryani/multi-worker:latest
docker push riteshvaryani/multi-client:$SHA
docker push riteshvaryani/multi-server:$SHA
docker push riteshvaryani/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=riteshvaryani/multi-client:$SHA
kubectl set image deployments/server-deployment server=riteshvaryani/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=riteshvaryani/multi-worker:$SHA
docker build -t aalandril/multi-client:latest -t aalandril/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aalandril/multi-server:latest -t aalandril/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aalandril/multi-worker:latest -t aalandril/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aalandril/multi-client:latest
docker push aalandril/multi-server:latest
docker push aalandril/multi-worker:latest

docker push aalandril/multi-client:$SHA
docker push aalandril/multi-server:$SHA
docker push aalandril/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aalandril/multi-server:$SHA
kubectl set image deployments/client-deployment client=aalandril/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aalandril/multi-worker:$SHA

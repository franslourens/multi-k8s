docker build -t franslourens/multi-client:latest -t franslourens/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t franslourens/multi-server:latest -t franslourens/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t franslourens/multi-worker:latest -t franslourens/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push franslourens/multi-client:latest
docker push franslourens/multi-server:latest
docker push franslourens/multi-worker:latest

docker push franslourens/multi-client:$SHA
docker push franslourens/multi-server:$SHA
docker push franslourens/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=franslourens/multi-server:$SHA
kubectl set image deployments/client-deployment client=franslourens/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=franslourens/multi-worker:$SHA

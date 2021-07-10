docker build -t tchakrab/multi-client:latest tchakrab/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tchakrab/multi-server:latest tchakrab/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tchakrab/multi-worker:latest tchakrab/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tchakrab/multi-client:latest
docker push tchakrab/multi-server:latest
docker push tchakrab/multi-worker:latest

docker push tchakrab/multi-client:$SHA
docker push tchakrab/multi-server:$SHA
docker push tchakrab/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tchakrab/multi-server:$SHA
kubectl set image deployments/client-deployment client=tchakrab/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tchakrab/multi-worker:$SHA
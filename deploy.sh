docker build -t tromedo/multi-client:latest -t tromedo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tromedo/multi-server:latest -t tromedo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tromedo/multi-worker:latest -t tromedo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tromedo/multi-client:latest
docker push tromedo/multi-server:latest
docker push tromedo/multi-worker:latest

docker push tromedo/multi-client:$SHA
docker push tromedo/multi-server:$SHA
docker push tromedo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tromedo/multi-server:$SHA
kubectl set image deployments/client-deployment client=tromedo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tromedo/multi-worker:$SHA
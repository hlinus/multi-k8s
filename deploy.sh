docker build -t hlinus/multi-client:latest -t hlinus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hlinus/multi-server:latest -t hlinus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hlinus/multi-worker:latest -t hlinus/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hlinus/multi-client:latest
docker push hlinus/multi-client:$SHA
docker push hlinus/multi-server:latest
docker push hlinus/multi-server:$SHA
docker push hlinus/multi-worker:latest
docker push hlinus/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hlinus/multi-server:$SHA
kubectl set image deployments/client-deployment client=hlinus/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hlinus/multi-worker:$SHA
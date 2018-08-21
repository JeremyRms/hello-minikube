start: k8s minikube build-hellonode k8s-deploy k8s-expose minikube-service minikube-dashboard

build-hellonode:
	@echo "=============== build hellonode================"
	docker build -t hello-node:v1 ./hellonode

k8s:
	@echo "=============== k8s ================="
	sudo kubectl config use-context minikube

minikube:
	@echo "=============== minikube =============="
	sudo minikube start  # --vm-driver=none

minikube-dashboard:
	@echo "=============== minikube-dashboard =============="
	minikube dashboard &

k8s-deploy:
	@echo "=============== k8s-deploy =============="
	kubectl run hello-node --image=hello-node:v1 --port=8080 --image-pull-policy=Never &

k8s-expose:
	@echo "=============== k8s-expose =============="
	kubectl expose deployment hello-node --type=LoadBalancer || true

log-deploys:
	@echo "=============== log-deploys =============="
	kubectl get deployments

log-pods:
	@echo "=============== log-pods =============="
	kubectl get pods

log-events:
	@echo "=============== log-events =============="
	kubectl get events

log-service:
	@echo "=============== log-service =============="
	kubectl get services

minikube-service:
	@echo "=============== minikube-service =============="
	minikube service hello-node &

log-k8s:
	@echo "=============== logs-k8s =============="
	kubectl get po,svc -n kube-system


clean:
	@echo "=============== clean =============="
	kubectl delete service hello-node
	kubectl delete deployment hello-node
	docker rmi hello-node:v1 hello-node:v2 -f
	minikube stop
	minikube delete


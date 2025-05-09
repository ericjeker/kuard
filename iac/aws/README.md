# Terraform Configuration for a simple AWS EKS Cluster

## Considerations

* Not production-ready (Nodes are public, not behind a NAT)
* Minimal security configurations
* Suitable for testing/learning

## Cost Considerations

* AWS EKS: \$0.10 per cluster per hour (\$72/month, DO: \$12/month)
* EKS Auto Mode: \$0.00634 per hour for t3.medium (\$4.56/month)
* AWS EC2: \$0.0264 per hour for t3.small (\$19/month, DO: \$18/month)
* Data transfer: \$0.09 per GB

## Recommended Improvements

* Create public/private subnets, routed with a NAT Gateway
* Put the Nodes in the private subnet, only the ELB is in the public subnet
* Implement network policies and route tables properly to route the traffic
* Add logging and monitoring

## Installation

```shell
terraform init
terraform apply
```

### Update the kubeconfig with:

```shell
aws eks update-kubeconfig --name minimal-eks-cluster --region eu-central-2
```

### Add a metrics server:
  
```shell
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### Add Contour ingress:
  
```shell
kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
```

### Add cert-manager:

```shell
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml
```

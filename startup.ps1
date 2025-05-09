$currentLocation = Get-Location

Write-Host "Applying terraform..." -ForegroundColor Magenta

Set-Location -Path "iac/aws"
terraform apply -auto-approve
$cluster_name = terraform output -raw cluster_name
Set-Location -Path $currentLocation

Write-Host "Setting up local kube config..." -ForegroundColor Magenta

aws eks update-kubeconfig --name $cluster_name --region eu-central-2

Write-Host "Installing metrics server..." -ForegroundColor Magenta

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

Write-Host "Installing Contour ingress..." -ForegroundColor Magenta

kubectl apply -f https://projectcontour.io/quickstart/contour.yaml

Write-Host "Done!" -ForegroundColor Magenta

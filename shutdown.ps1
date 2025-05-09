$currentLocation = Get-Location

# Define namespaces to clean
$namespaces = @("default", "projectcontour", "cert-manager")

# Resource types to delete
$resourceTypes = @(
    "ingress", "services", "deployments", "daemonsets",
    "replicasets", "jobs", "pods", "configmaps", "secrets"
)

# Delete resources from each namespace
foreach ($namespace in $namespaces) {
    Write-Host "Delete namespace $namespace..." -ForegroundColor Magenta

    foreach ($resourceType in $resourceTypes) {
        kubectl delete $resourceType --all -n $namespace --ignore-not-found
    }
}

# Delete Custom Resource Definitions related to cert-manager and Contour
kubectl delete crd -l app.kubernetes.io/name=cert-manager --ignore-not-found
kubectl delete crd -l app.kubernetes.io/name=contour --ignore-not-found

Write-Host "Destroying terraform..." -ForegroundColor Magenta

Set-Location -Path "iac/aws"
terraform destroy -auto-approve
Set-Location -Path $currentLocation


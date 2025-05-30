# Create the queue
Invoke-RestMethod -Uri "http://localhost:8080/memq/server/queues/keygen" -Method Put

# Enqueue items work-item-0 to work-item-99
for ($i = 0; $i -le 99; $i++) {
    $item = "work-item-$i"
    Invoke-RestMethod -Uri "http://localhost:8080/memq/server/queues/keygen/enqueue" `
        -Method Post `
        -Body $item
}

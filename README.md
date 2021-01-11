# Geott

# Start

```shell
mix deps.get
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server
```

# Workflow

1. The manager creates a task with location [lat1, long1]
```
POST http://localhost:4000/api/auth/login
{
    "email": "manager1@com.com",
    "password": "12345678"
}

POST http://localhost:4000/api/tasks/
{
    "task": {
        "delivery": [36.9639657, -121.8097725],
        "pickup": [36.9639657, -121.8097725]
    }
}

```

2. The driver gets the list of the nearest tasks by submitting current location [lat2, long2]
```
POST http://localhost:4000/api/auth/login
{
    "email": "driver1@com.com",
    "password": "12345678"
}

POST http://localhost:4000/api/tasks/search
{
    "params": { "location" : [59, -55] }
}
```

3. Driver picks one task from the list (the task becomes assigned)
```
PUT http://localhost:4000/api/tasks/ad68770f-a6f3-4ddd-bd7d-a04b1239d8d3
{
    "task": {
        "status": "assigned"
    }
}
```

4. Driver finishes the task (becomes done)
```
PUT http://localhost:4000/api/tasks/ad68770f-a6f3-4ddd-bd7d-a04b1239d8d3
{
    "task": {
        "status": "done"
    }
}
```


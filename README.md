
# README

## Tea Subscriptions Service

This api allows customers to subscribe to a tea subscription, cancel a tea subscription, and view all of their subscriptions, active and cancelled.

## Sections

- Schema & DB Vizualization
- DB Setup
- Endpoints

## Schema & DB Vizualization
<img width="817" alt="Screenshot 2024-01-25 at 5 17 29 PM" src="https://github.com/TheAveryRodriguez/tea_subscriptions/assets/22011212/fae6e44b-5f1d-4333-b416-fa191861f97a">
<img width="870" alt="Screenshot 2024-01-25 at 5 17 54 PM" src="https://github.com/TheAveryRodriguez/tea_subscriptions/assets/22011212/521f8275-332c-4049-ae8c-0666e3e73ec3">

<img width="786" alt="Screenshot 2024-01-25 at 5 16 37 PM" src="https://github.com/TheAveryRodriguez/tea_subscriptions/assets/22011212/944b352d-88b3-4080-b7b2-b7d6e4dd4404">

## DB Setup

Make sure to fork and then clone this repo

Once you have successfully cloned this repo run: 
```
rails db:{drop,create,migrate,seed}
```

Your set up is complete!

## Endpoints

Subscribe a Customer to a Tea Subscription
```
POST "/api/v1/customers/:customer_id/subscriptions/:subscription_id"
```

Cancel a Customer's Tea Subscription
```
PATCH "/api/v1/customers/:customer_id/subscriptions/:subscription_id"
```

See all of a Customer's Subscriptions
```
GET "/api/v1/customers/:customer_id/subscriptions
:customer_id"
```

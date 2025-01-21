# Define the Pub/Sub Topic
resource "google_pubsub_topic" "user_submit_topic" {
  name = var.pubsub_topic_name
  project = var.service_project_id
}


# Define the Subscription
resource "google_pubsub_subscription" "user_submit_subscription" {
  name  = var.pubsub_subscription_name
  topic = var.pubsub_topic_name
  project = var.service_project_id

  ack_deadline_seconds = 20

}



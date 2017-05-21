// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "test-computeengine-168212"
  region      = "europe-west1"
}

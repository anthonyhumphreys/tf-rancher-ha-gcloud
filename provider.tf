provider "google" {
  credentials = "${file("account.json")}"
  project     = "thss-services"
  region      = "europe-west2"
}

terraform {
  backend "gcs" {
    bucket      = "terraform-remote-backend-xxxxxxxxxxxxxxxx"
    prefix      = "storage"
    credentials = "keys/terraform-state-storage-xxxxxx-xxxxxxxxxxxx.json"
  }
}

provider "google" {
  credentials = file("keys/storage-xxxxxx-xxxxxxxxxxxx.json")
  project     = "place-project-id-here"
  region      = "us-west1"
}

resource "google_storage_bucket" "public" {
  force_destroy = true
  name     = "place-domain-name-here"
  location = "US"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://place-domain-name-here"]
    method          = ["GET", "HEAD", "POST"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.public.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.public.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  source = "www/index.html"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "not_found" {
  name   = "404.html"
  source = "www/404.html"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "background" {
  name   = "swiss-alps-wallpaper-free_5900985.jpg"
  source = "www/swiss-alps-wallpaper-free_5900985.jpg"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "logo" {
  name   = "inventive-technology-logo.png"
  source = "www/inventive-technology-logo.png"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "favicon_chrome_small" {
  name   = "android-chrome-192x192.png"
  source = "www/android-chrome-192x192.png"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "favicon_chrome_large" {
  name   = "android-chrome-512x512.png"
  source = "www/android-chrome-512x512.png"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "favicon_apple" {
  name   = "apple-touch-icon.png"
  source = "www/apple-touch-icon.png"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "favicon_small" {
  name   = "favicon-16x16.png"
  source = "www/favicon-16x16.png"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "favicon_large" {
  name   = "favicon-32x32.png"
  source = "www/favicon-32x32.png"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "favicon" {
  name   = "favicon.ico"
  source = "www/favicon.ico"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}

resource "google_storage_bucket_object" "webmanifest" {
  name   = "site.webmanifest"
  source = "www/site.webmanifest"
  bucket = google_storage_bucket.public.name
  depends_on = [google_storage_default_object_access_control.public_rule]
}
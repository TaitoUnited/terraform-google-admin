output "service_accounts" {
  value = google_service_account.service_account
}

output "apis" {
  value = google_project_service.api
}

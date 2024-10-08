/**
 * Copyright 2021 Taito United
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_project_iam_member" "member" {
  for_each   = {for item in local.memberRoles: item.key => item}

  role       = each.value.role
  member     = each.value.member
  project    = var.project_id
}

resource "google_project_iam_member" "service_account" {
  depends_on = [google_service_account.service_account]
  for_each   = {for item in local.serviceAccountRoles: item.key => item}

  role       = each.value.role
  member     = each.value.member
  project    = var.project_id
}

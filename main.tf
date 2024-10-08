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

locals {
  permissions = coalesce(var.permissions, [])
  apis = coalesce(var.apis, [])
  serviceAccounts = coalesce(var.service_accounts, [])

  memberRoles = flatten([
    for member in local.permissions: [
      for role in member.roles:
      {
        key  = "${member.id}-${role}"
        role = role
        member = member.id
      }
    ]
  ])

  serviceAccountRoles = flatten([
    for serviceAccount in local.serviceAccounts: [
      for role in serviceAccount.roles:
      {
        key  = "${serviceAccount.id}-${role}"
        role = role
        member = "serviceAccount:${serviceAccount.id}@${var.project_id}.iam.gserviceaccount.com"
      }
    ]
  ])
}

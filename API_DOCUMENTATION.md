# Riye App API Documentation

## Overview

The Riye App API provides RESTful endpoints for managing construction project data including workers, attendances, projects, companies, stocks, and more. All API endpoints require authentication using API keys.

## Authentication

All API requests must include authentication headers:

```
X-API-Key: your_access_key_here
X-API-Secret: your_secret_key_here (optional, for additional security)
```

### Creating API Keys

API keys can be created through the web interface at `/api_accesses` or programmatically:

**Example API Key Creation:**
- Name: `narenthar`
- User: `narenthar.bluvent@gmail.com`
- Permissions: Leave blank for full access or specify comma-separated permissions
- Expiration: Optional

API keys can be managed through the web interface at `/api_accesses`.

## Base URL

```
https://your-domain.com/api/v1/
```

## Response Format

All responses are in JSON format. Successful responses return HTTP 200 with the requested data. Error responses include appropriate HTTP status codes and error messages.

## Common Response Codes

- `200` - Success
- `401` - Unauthorized (invalid or missing API key)
- `403` - Forbidden (insufficient permissions)
- `404` - Not Found
- `422` - Unprocessable Entity (validation errors)
- `500` - Internal Server Error

---

## Attendances API

Manage worker attendance records.

### List Attendances

**GET** `/api/v1/attendances`

**Query Parameters:**
- `filter` (optional): `week`, `month`, or omit for today

**Example Request:**
```bash
curl -H "X-API-Key: your_generated_access_key" \
     -H "X-API-Secret: your_generated_secret_key" \
     https://your-domain.com/api/v1/attendances
```

**Example Response:**
```json
[
  {
    "id": 1,
    "punch_in": "2025-10-25T09:00:00.000Z",
    "punch_out": "2025-10-25T17:00:00.000Z",
    "punch_in_location": "Site A",
    "punch_out_location": "Site A",
    "approved": false,
    "created_at": "2025-10-25T09:00:00.000Z",
    "updated_at": "2025-10-25T17:00:00.000Z",
    "worker": {
      "id": 1,
      "name": "John Doe",
      "contact": "1234567890"
    }
  }
]
```

### Get Attendance

**GET** `/api/v1/attendances/:id`

**Example Request:**
```bash
curl -H "X-API-Key: your_generated_access_key" \
     https://your-domain.com/api/v1/attendances/1
```

### Update Attendance

**PATCH/PUT** `/api/v1/attendances/:id`

**Request Body:**
```json
{
  "attendance": {
    "punch_in": "2025-10-25T09:00:00.000Z",
    "punch_out": "2025-10-25T17:00:00.000Z",
    "punch_in_location": "Site A",
    "punch_out_location": "Site A",
    "approved": true
  }
}
```

---

## Companies API

Manage company records.

### List Companies

**GET** `/api/v1/companies`

**Example Request:**
```bash
curl -H "X-API-Key: your_generated_access_key" \
     https://your-domain.com/api/v1/companies
```

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "ABC Construction",
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z"
  }
]
```

### Get Company

**GET** `/api/v1/companies/:id`

### Update Company

**PATCH/PUT** `/api/v1/companies/:id`

**Request Body:**
```json
{
  "company": {
    "name": "Updated Company Name"
  }
}
```

---

## Projects API

Manage project records.

### List Projects

**GET** `/api/v1/projects`

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "Building Complex A",
    "location": "Downtown",
    "status": "active",
    "start_date": "2025-01-01",
    "end_date": "2025-12-31",
    "customer_budget": "1000000.0",
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "company": {
      "id": 1,
      "name": "ABC Construction"
    },
    "user": {
      "id": 1,
      "email": "manager@example.com"
    }
  }
]
```

### Get Project

**GET** `/api/v1/projects/:id`

### Update Project

**PATCH/PUT** `/api/v1/projects/:id`

**Request Body:**
```json
{
  "project": {
    "name": "Updated Project Name",
    "location": "New Location",
    "status": "completed",
    "start_date": "2025-01-01",
    "end_date": "2025-12-31",
    "customer_budget": "1500000.0"
  }
}
```

---

## Workers API

Manage worker records.

### List Workers

**GET** `/api/v1/workers`

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "contact": "1234567890",
    "worker_id": "W001",
    "nature_of_worker": 0,
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "project": {
      "id": 1,
      "name": "Building Complex A"
    },
    "team": {
      "id": 1,
      "name": "Team Alpha"
    },
    "head_worker": {
      "id": 2,
      "name": "Jane Smith"
    }
  }
]
```

### Get Worker

**GET** `/api/v1/workers/:id`

### Update Worker

**PATCH/PUT** `/api/v1/workers/:id`

**Request Body:**
```json
{
  "worker": {
    "name": "Updated Name",
    "contact": "0987654321",
    "project_id": 1,
    "team_id": 1,
    "head_worker_id": 2
  }
}
```

---

## Stocks API

Manage stock/inventory records.

### List Stocks

**GET** `/api/v1/stocks`

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "Cement",
    "quantity": 100,
    "unit": "bags",
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "company": {
      "id": 1,
      "name": "ABC Construction"
    },
    "project": {
      "id": 1,
      "name": "Building Complex A"
    }
  }
]
```

### Get Stock

**GET** `/api/v1/stocks/:id`

### Update Stock

**PATCH/PUT** `/api/v1/stocks/:id`

**Request Body:**
```json
{
  "stock": {
    "name": "Updated Cement",
    "quantity": 150,
    "unit": "bags",
    "company_id": 1,
    "project_id": 1
  }
}
```

---

## Daily Updates API

Manage daily update records.

### List Daily Updates

**GET** `/api/v1/daily_updates`

**Example Response:**
```json
[
  {
    "id": 1,
    "note": "Completed foundation work",
    "approved": false,
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "user": {
      "id": 1,
      "email": "worker@example.com"
    }
  }
]
```

### Get Daily Update

**GET** `/api/v1/daily_updates/:id`

### Update Daily Update

**PATCH/PUT** `/api/v1/daily_updates/:id`

**Request Body:**
```json
{
  "daily_update": {
    "note": "Updated progress report",
    "approved": true
  }
}
```

---

## Bank Details API

Manage worker bank details.

### List Bank Details

**GET** `/api/v1/bank_details`

**Example Response:**
```json
[
  {
    "id": 1,
    "name_of_beneficiary": "John Doe",
    "account_number": "1234567890",
    "bank_name": "State Bank",
    "ifsc_code": "SBIN0001234",
    "branch_name": "Main Branch",
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "worker": {
      "id": 1,
      "name": "John Doe"
    }
  }
]
```

### Get Bank Details

**GET** `/api/v1/bank_details/:id`

### Update Bank Details

**PATCH/PUT** `/api/v1/bank_details/:id`

**Request Body:**
```json
{
  "bank_detail": {
    "name_of_beneficiary": "John Doe",
    "account_number": "1234567890",
    "bank_name": "Updated Bank",
    "ifsc_code": "UBIN0001234",
    "branch_name": "City Branch"
  }
}
```

---

## Teams API

Manage team records.

### List Teams

**GET** `/api/v1/teams`

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "Team Alpha",
    "nature_of_skill": "local_team",
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "team_head": {
      "id": 1,
      "name": "Team Leader"
    },
    "workers": [
      {
        "id": 1,
        "name": "John Doe"
      }
    ]
  }
]
```

### Get Team

**GET** `/api/v1/teams/:id`

### Update Team

**PATCH/PUT** `/api/v1/teams/:id`

**Request Body:**
```json
{
  "team": {
    "name": "Updated Team Name",
    "nature_of_skill": "skilled_team",
    "team_head_id": 1
  }
}
```

---

## Team Heads API

Manage team head records.

### List Team Heads

**GET** `/api/v1/team_heads`

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "Team Leader",
    "dob": "1980-01-01",
    "age": 45,
    "gender": "Male",
    "address": "123 Main St",
    "aadhaar_number": "123456789012",
    "contact_number": "1234567890",
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "teams": [
      {
        "id": 1,
        "name": "Team Alpha"
      }
    ]
  }
]
```

### Get Team Head

**GET** `/api/v1/team_heads/:id`

### Update Team Head

**PATCH/PUT** `/api/v1/team_heads/:id`

**Request Body:**
```json
{
  "team_head": {
    "name": "Updated Name",
    "age": 46,
    "contact_number": "0987654321"
  }
}
```

---

## Users API

Manage user records.

### List Users

**GET** `/api/v1/users`

**Example Response:**
```json
[
  {
    "id": 1,
    "email": "user@example.com",
    "role": 1,
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z"
  }
]
```

### Get User

**GET** `/api/v1/users/:id`

### Update User

**PATCH/PUT** `/api/v1/users/:id`

**Request Body:**
```json
{
  "user": {
    "email": "updated@example.com",
    "role": 2
  }
}
```

---

## Replies API

Manage reply records for daily updates.

### List Replies

**GET** `/api/v1/replies`

**Example Response:**
```json
[
  {
    "id": 1,
    "content": "Good work!",
    "created_at": "2025-10-25T10:00:00.000Z",
    "updated_at": "2025-10-25T10:00:00.000Z",
    "daily_update": {
      "id": 1,
      "note": "Completed foundation work"
    },
    "user": {
      "id": 1,
      "email": "manager@example.com"
    }
  }
]
```

### Get Reply

**GET** `/api/v1/replies/:id`

### Update Reply

**PATCH/PUT** `/api/v1/replies/:id`

**Request Body:**
```json
{
  "reply": {
    "content": "Updated reply content"
  }
}
```

---

## API Key Management

API keys can be managed through the web interface:

1. Navigate to `/api_accesses`
2. Create new API keys with specific permissions
3. View usage statistics and last access times
4. Deactivate or delete keys as needed

### Permissions

Available permissions for API keys:
- `attendances` - Access attendance endpoints
- `companies` - Access company endpoints
- `projects` - Access project endpoints
- `workers` - Access worker endpoints
- `stocks` - Access stock endpoints
- `daily_updates` - Access daily update endpoints
- `bank_details` - Access bank details endpoints
- `teams` - Access team endpoints
- `team_heads` - Access team head endpoints
- `users` - Access user endpoints
- `replies` - Access reply endpoints

Leave permissions blank to grant access to all endpoints.

---

## Rate Limiting

The API implements rate limiting to prevent abuse. Current limits:
- 1000 requests per hour per API key
- 100 requests per minute per API key

---

## Error Handling

All errors return JSON with an `error` key:

```json
{
  "error": "API key is required"
}
```

For validation errors:

```json
{
  "errors": {
    "name": ["can't be blank"],
    "email": ["is invalid"]
  }
}
```

---

## Support

For API support or questions, please contact the development team.
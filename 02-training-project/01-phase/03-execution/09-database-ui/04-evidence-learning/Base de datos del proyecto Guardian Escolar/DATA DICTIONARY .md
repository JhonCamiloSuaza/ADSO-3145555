# DATA DICTIONARY - GPS SCHOOL GUARDIAN (ENGLISH)

## ENUMS

| Enum | Values | Description |
|------|--------|-------------|
| **school_grade_enum** | 'PRE_KINDER', 'KINDER', 'TRANSITION', 'FIRST', 'SECOND', 'THIRD', 'FOURTH', 'FIFTH', 'SIXTH', 'SEVENTH', 'EIGHTH', 'NINTH', 'TENTH', 'ELEVENTH' | School grades from Pre-Kinder to 11th grade |
| **trip_status_enum** | 'PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED' | School trip statuses |
| **session_status_enum** | 'ACTIVE', 'EXPIRED', 'LOGOUT' | User session statuses |
| **role_name_enum** | 'ADMIN', 'PARENT' | System roles |

---

## TABLES

### 1. User

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique user identifier |
| FullName | VARCHAR(100) | NO | - | User's full name |
| Email | VARCHAR(100) | NO | - | Email address (unique) |
| Phone | VARCHAR(30) | YES | - | Phone number |
| PasswordHash | VARCHAR(255) | NO | - | Password hash |
| IsActive | BOOLEAN | YES | true | Active/Inactive user |
| EmailVerified | BOOLEAN | YES | false | Email verified status |
| EmailVerificationToken | VARCHAR(255) | YES | - | Email verification token |
| EmailVerificationExpiry | TIMESTAMPTZ | YES | - | Verification token expiry |
| PasswordResetToken | VARCHAR(255) | YES | - | Password reset token |
| PasswordResetExpiry | TIMESTAMPTZ | YES | - | Reset token expiry |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Record creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update date |
| DeletedAt | TIMESTAMPTZ | YES | - | Soft delete date |
| CreatedBy | UUID | YES | - | User who created record (FK) |
| UpdatedBy | UUID | YES | - | User who updated record (FK) |

---

### 2. Route

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique route identifier |
| RouteName | VARCHAR(100) | NO | - | Route name |
| Description | TEXT | YES | - | Detailed description |
| OriginLat | DECIMAL(9,6) | YES | - | Origin latitude |
| OriginLon | DECIMAL(9,6) | YES | - | Origin longitude |
| DestinationLat | DECIMAL(9,6) | YES | - | Destination latitude |
| DestinationLon | DECIMAL(9,6) | YES | - | Destination longitude |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Update date |
| DeletedAt | TIMESTAMPTZ | YES | - | Soft delete |
| CreatedBy | UUID | YES | - | Created by user (FK) |
| UpdatedBy | UUID | YES | - | Updated by user (FK) |

---

### 3. Student

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique student identifier |
| UserID | UUID | NO | - | Associated parent (FK to User) |
| FullName | VARCHAR(100) | NO | - | Student's full name |
| SchoolGrade | school_grade_enum | YES | - | Current school grade |
| BirthDate | DATE | YES | - | Birth date |
| IsActive | BOOLEAN | YES | true | Active/Inactive student |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Registration date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |
| DeletedAt | TIMESTAMPTZ | YES | - | Soft delete |
| CreatedBy | UUID | YES | - | Created by user (FK) |
| UpdatedBy | UUID | YES | - | Updated by user (FK) |

---

### 4. Student_Route

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| StudentID | UUID | NO | - | Student (FK to Student) |
| RouteID | UUID | NO | - | Route (FK to Route) |
| IsActive | BOOLEAN | YES | true | Active assignment |
| AssignedAt | TIMESTAMPTZ | YES | NOW() | Assignment date |

**PK: (StudentID, RouteID)**

---

### 5. EmergencyContact

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| StudentID | UUID | NO | - | Associated student (FK) |
| FullName | VARCHAR(100) | NO | - | Contact full name |
| Phone | VARCHAR(30) | NO | - | Contact phone |
| Relationship | VARCHAR(50) | YES | - | Relationship (Mother, Father, etc.) |
| IsPrimary | BOOLEAN | YES | false | Primary contact |
| IsActive | BOOLEAN | YES | true | Active contact |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |
| DeletedAt | TIMESTAMPTZ | YES | - | Soft delete |
| CreatedBy | UUID | YES | - | Created by user (FK) |
| UpdatedBy | UUID | YES | - | Updated by user (FK) |

---

### 6. Stop

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| RouteID | UUID | NO | - | Associated route (FK to Route) |
| StopOrder | INTEGER | NO | - | Stop order (1,2,3...) |
| StopName | VARCHAR(100) | YES | - | Stop name |
| Latitude | DECIMAL(9,6) | NO | - | Stop latitude |
| Longitude | DECIMAL(9,6) | NO | - | Stop longitude |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |

---

### 7. SafeZone

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| StudentID | UUID | NO | - | Associated student (FK) |
| ZoneName | VARCHAR(100) | NO | - | Zone name |
| Latitude | DECIMAL(9,6) | NO | - | Center latitude |
| Longitude | DECIMAL(9,6) | NO | - | Center longitude |
| RadiusMeters | INTEGER | NO | - | Radius in meters |
| InactivityThresholdSeconds | INTEGER | NO | 300 | Inactivity time for alert |
| IsActive | BOOLEAN | YES | true | Active zone |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |
| DeletedAt | TIMESTAMPTZ | YES | - | Soft delete |
| CreatedBy | UUID | YES | - | Created by user (FK) |
| UpdatedBy | UUID | YES | - | Updated by user (FK) |

---

### 8. NotificationConfig

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| UserID | UUID | NO | - | User (FK to User) |
| DelayAlert | BOOLEAN | YES | true | Delay alerts |
| RouteChangeAlert | BOOLEAN | YES | true | Route change alerts |
| ArrivalAlert | BOOLEAN | YES | true | Arrival alerts |
| InactivityAlert | BOOLEAN | YES | true | Inactivity alerts |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |

---

### 9. Trip

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| StudentID | UUID | NO | - | Student (FK to Student) |
| RouteID | UUID | NO | - | Route (FK to Route) |
| StartDateTime | TIMESTAMPTZ | NO | - | Start date/time |
| EndDateTime | TIMESTAMPTZ | YES | - | End date/time |
| Status | trip_status_enum | YES | 'PENDING' | Trip status |
| HasDetour | BOOLEAN | YES | false | Had detour |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |
| DeletedAt | TIMESTAMPTZ | YES | - | Soft delete |
| CreatedBy | UUID | YES | - | Created by user (FK) |
| UpdatedBy | UUID | YES | - | Updated by user (FK) |

---

### 10. Coordinate

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| TripID | UUID | NO | - | Associated trip (FK) |
| Latitude | DECIMAL(9,6) | NO | - | Location latitude |
| Longitude | DECIMAL(9,6) | NO | - | Location longitude |
| RecordedAt | TIMESTAMPTZ | NO | - | GPS reading time |
| SpeedKmh | DECIMAL(5,1) | YES | - | Speed in km/h |
| StopDurationSeconds | INTEGER | YES | 0 | Stopped duration (seconds) |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |

---

### 11. Notification

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| TripID | UUID | YES | - | Associated trip (FK) |
| SafeZoneID | UUID | YES | - | Associated safe zone (FK) |
| EventType | VARCHAR(50) | NO | - | Event type |
| Message | TEXT | NO | - | Notification message |
| EventDateTime | TIMESTAMPTZ | YES | CURRENT_TIMESTAMP | Event date/time |
| IsSent | BOOLEAN | YES | false | Was sent |

---

### 12. NotificationReceipt

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| NotificationID | UUID | NO | - | Notification (FK) |
| UserID | UUID | NO | - | Destination user (FK) |
| IsRead | BOOLEAN | YES | false | Was read |
| ReceivedAt | TIMESTAMPTZ | YES | CURRENT_TIMESTAMP | Reception date |
| ReadAt | TIMESTAMPTZ | YES | - | Read date |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |

---

## SECURITY TABLES

### 13. Role

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| RoleName | role_name_enum | NO | - | Role name |
| Description | VARCHAR(255) | YES | - | Role description |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |

---

### 14. Permission

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| PermissionName | VARCHAR(100) | NO | - | Permission name |
| Description | TEXT | YES | - | Permission description |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |

---

### 15. User_Role

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| UserID | UUID | NO | - | User (FK to User) |
| RoleID | UUID | NO | - | Role (FK to Role) |
| AssignedAt | TIMESTAMPTZ | YES | CURRENT_TIMESTAMP | Assignment date |

**PK: (UserID, RoleID)**

---

### 16. Role_Permission

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| RoleID | UUID | NO | - | Role (FK to Role) |
| PermissionID | UUID | NO | - | Permission (FK to Permission) |

**PK: (RoleID, PermissionID)**

---

### 17. UserSession

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| UserID | UUID | NO | - | User (FK to User) |
| Token | VARCHAR(500) | NO | - | Session token |
| StartedAt | TIMESTAMPTZ | YES | CURRENT_TIMESTAMP | Session start |
| EndedAt | TIMESTAMPTZ | YES | - | Session end |
| OriginIp | INET | YES | - | Origin IP |
| SessionStatus | session_status_enum | YES | 'ACTIVE' | Session status |
| CreatedAt | TIMESTAMPTZ | YES | NOW() | Creation date |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Last update |

---

## CONFIGURATION TABLES

### 18. PasswordPolicy

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| MinLength | INT | YES | 10 | Minimum length |
| MaxLength | INT | YES | 128 | Maximum length |
| RequireUppercase | BOOLEAN | YES | true | Requires uppercase |
| RequireNumbers | BOOLEAN | YES | true | Requires numbers |
| RequireSymbols | BOOLEAN | YES | true | Requires symbols |
| ExpirationDays | INT | YES | 90 | Expiration days |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Update date |
| UpdatedBy | UUID | YES | - | Updated by user (FK) |

---

### 19. SecurityConfiguration

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| ConfigName | VARCHAR(100) | NO | - | Configuration name |
| ConfigValue | TEXT | YES | - | Configuration value |
| Description | TEXT | YES | - | Description |
| UpdatedAt | TIMESTAMPTZ | YES | NOW() | Update date |
| UpdatedBy | UUID | YES | - | Updated by user (FK) |

---

## LOG TABLES

### 20. ActivityLog

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| UserID | UUID | YES | - | Executing user (FK) |
| ActionType | VARCHAR(50) | NO | - | Action type |
| Description | TEXT | YES | - | Action description |
| OriginIp | INET | YES | - | Origin IP |
| Metadata | JSONB | YES | - | Additional JSON data |
| CreatedAt | TIMESTAMP | YES | CURRENT_TIMESTAMP | Log date/time |

---

### 21. AuditLog

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| UserID | UUID | YES | - | Executing user (FK) |
| Action | VARCHAR(255) | NO | - | Action performed |
| Description | TEXT | YES | - | Description |
| OriginIp | INET | YES | - | Origin IP |
| Application | VARCHAR(100) | YES | 'GPS_Guardian' | Source application |
| Metadata | JSONB | YES | - | Additional JSON data |
| CreatedAt | TIMESTAMP | YES | CURRENT_TIMESTAMP | Log date/time |

---

### 22. ErrorLog

| Field | Type | Nullable | Default | Description |
|-------|------|----------|---------|-------------|
| ID | UUID | NO | gen_random_uuid() | Unique identifier |
| UserID | UUID | YES | - | Related user (FK) |
| ErrorType | VARCHAR(100) | NO | - | Error type |
| Description | TEXT | YES | - | Error description |
| StackTrace | TEXT | YES | - | Error stack trace |
| OriginIp | INET | YES | - | Origin IP |
| Metadata | JSONB | YES | - | Additional JSON data |
| CreatedAt | TIMESTAMP | YES | CURRENT_TIMESTAMP | Error date/time |

---

## RELATIONSHIPS

| Relationship | Type |
|--------------|------|
| User (1) ──< (N) Student | One-to-Many |
| User (1) ──< (N) NotificationConfig | One-to-Many |
| User (1) ──< (N) UserSession | One-to-Many |
| User (N) ──> (N) Role (via User_Role) | Many-to-Many |
| Role (N) ──> (N) Permission (via Role_Permission) | Many-to-Many |
| Student (1) ──< (N) EmergencyContact | One-to-Many |
| Student (1) ──< (N) SafeZone | One-to-Many |
| Student (N) ──> (N) Route (via Student_Route) | Many-to-Many |
| Route (1) ──< (N) Stop | One-to-Many |
| Route (1) ──< (N) Trip | One-to-Many |
| Student (1) ──< (N) Trip | One-to-Many |
| Trip (1) ──< (N) Coordinate | One-to-Many |
| Trip (1) ──< (N) Notification | One-to-Many |
| Notification (1) ──< (N) NotificationReceipt | One-to-Many |

---

## SUMMARY

| Concept | Count |
|---------|-------|
| Tables | 22 |
| Enums | 4 |
| Indexes | 20+ |
| Relationships | 15+ |

---

**End of Data Dictionary - English**
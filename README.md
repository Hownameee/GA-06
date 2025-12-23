# GA-06

Finish OTP active user with UI and navigation between page. Prevent non-active user from using required login API  until fully activated (verified email).

## 🚀 Quick Start

### 1. Setup

```bash
# Install dependencies
npm install

# Create .env file based on the config below
touch backend/.env
```

### 2. Environment Configuration (.env)

```bash
PORT=4000
DATABASE_URL="postgresql://user:pass@host:5432/dbname"
JWT_SECRET="your-secret-key"
EMAIL="example@gmail.com"
PASSWORD="your-app-password"
```

### 3. Database Initialization

Run the provided SQL script in your PostgreSQL client (pgAdmin/DBeaver) to:

Clean up old tables.

Create schema (users, provinces, wards, orders) and insert sample data (sample.sql).

### 4. Run Server

```bash
npm run dev
```

### 5. References

Base code cloned and adapted from: [csc13008-23ktpm1/jwt](https://github.com/nguyenkha/csc13008-23ktpm1/tree/main/jwt)

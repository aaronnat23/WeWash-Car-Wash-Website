# claude.md – Car Wash Subscription SaaS (Malaysia-first, PWA)

## 0. Goal
Build a **car wash subscription + service marketplace** with:
- A **B2C app** for drivers
- A **B2B operator SaaS** for car wash merchants
- A **PWA** that works like an app on mobile
- Next.js + Typescript + Supabase
- Tailwind + shadcn/ui for modern UI

This file gives Claude/Codex everything needed to start coding.

---

# 1. FEATURE LIST (FULL + CLEAR)

## 1.1 B2C Features (Drivers)

### **A. Subscription System**
- Multiple subscription tiers (Basic, Standard, Premium)
- Monthly or yearly billing
- Unlimited washes *or* limited X washes per month
- Multi-car family plans (1–4 cars)
- Plans vary by:
  - Vehicle type (sedan vs SUV)
  - Service level (exterior only vs full wash)
  - Whether mobile/on-site wash is included
- Free trial (optional toggle)

### **B. Vehicle Management**
- Add multiple vehicles
- Save plate number, make/model, colour, type
- Assign vehicles to subscription
- Change primary vehicle anytime

### **C. Merchant Discovery**
- List + Map view of nearby car washes
- Filters:
  - Distance (1km, 3km, 5km, 10km)
  - “Open now”
  - “Supports your plan”
  - Exterior wash / Full wash / Vacuum / Detailing
  - Mobile wash available
- Merchant detail screen includes:
  - Photos, ratings, services, prices
  - Opening hours
  - Accepted subscription plans
  - Next available time slots

### **D. Booking System**
- Book time slot at chosen merchant
- Choose service type (standard wash, interior, detailing, add-ons)
- Choose vehicle
- Choose location
- For mobile wash: choose your address
- Booking confirmation & reminders
- Modify/cancel booking

### **E. Check-in & Redemption**
- App generates **dynamic QR / token**
- Staff scans QR
- Backup: 6-digit PIN code
- Booking marked as “completed” once service is done
- Subscription wash count updates instantly

### **F. Usage Tracking**
- Track number of washes used this billing cycle
- Usage vs limit (or “Unlimited washes used: X”)
- Show total savings:
  - “You saved RM 112 this month compared to pay-per-wash”
- View all past washes (history)

### **G. Ratings & Reviews**
- Rate merchant from 1–5 stars
- Optional comments
- Show average rating on merchant page

### **H. Profile / Settings**
- Edit profile
- Change password
- Language switch (English/Bahasa later)
- Manage payment methods
- Cancel subscription (Stripe)
- See subscription renewal date

---

## 1.2 B2B Features (Merchant Owners)

### **A. Merchant Dashboard**
- Total washes today
- Active bookings
- Upcoming bookings list
- Peak hour statistics
- Subscription vs one-off ratio

### **B. Locations Management**
- Add multiple branches
- Set GPS coordinates, images, description
- Set opening hours
- Enable/disable mobile wash service
- Real-time “open / closed” toggle

### **C. Service Management**
- Add services (wash, vacuum, polish, detailing)
- Add-on pricing
- Set duration for each service
- Vehicle-type specific pricing

### **D. Booking Management**
- Accept or auto-accept bookings
- View timeline of bookings
- Mark booking:
  - In-progress
  - Completed
  - No-show
- Override or edit booking time slot

### **E. Wash Redemption**
- Staff portal:
  - Scan customer QR
  - Redeem wash
  - Mark job as completed

### **F. Staff Accounts**
- Owner can add staff with limited permissions
- Staff roles:
  - Manager
  - Front desk
  - Washer (only scan + complete)

### **G. Analytics**
- Wash frequency charts (daily/weekly/monthly)
- Subscription usage
- Revenue estimation (subscription share + add-ons)
- Customer repeat rate
- Peak hour heatmap
- Most popular services
- Branch-wise comparison

---

## 1.3 Admin Features

- Approve merchant onboarding
- Suspend merchants or users
- Manage global subscription plans
- Global reporting dashboards:
  - Total subscriptions
  - Monthly Recurring Revenue (MRR)
  - Churn rate
  - Top merchants by volume
- Fraud monitoring:
  - Suspicious repeated redemptions
  - Out-of-radius mobile wash activity

---

# 2. FEATURE GAPS (MARKET OPPORTUNITY)

### Gaps in Malaysia + how we exploit them:

#### **Gap 1 – No full SaaS + consumer app combo**
Most competitors only offer membership cards or simple apps.
**We offer:**  
- Full operator dashboard + PWA driver app + bookings + QR redemption.

#### **Gap 2 – Weak mobile wash integration**
Most do not support on-site condo/office washes well.
**We offer:**  
- Mobile wash mode with address input + scheduling.

#### **Gap 3 – No real analytics**
Most car wash shops operate blind.
**We offer:**  
- Usage analytics, heatmaps, revenue forecasting.

#### **Gap 4 – No unlimited wash subscription in modern UX**
We bring the US-style unlimited-wash subscription with:
- Instant activation
- QR check-in
- In-app usage tracking

#### **Gap 5 – No PWA-first local competitor**
We implement:
- Offline-capable
- Installable on Android/iPhone
- Mobile-optimised UI with shadcn

---

# 3. TECH STACK

### Frontend
- **Next.js (App Router)**
- **Typescript**
- **Tailwind CSS**
- **shadcn/ui** components
- TanStack Query (data caching + remote state)
- Map provider: Mapbox / Google Maps JS SDK

### Backend
- Next.js Route Handlers (API)
- Supabase:
  - Postgres
  - Auth (email/password)  
  - Storage (merchant photos, car photos)
  - RLS + row-level policies

### Payments
- **Stripe** subscription billing (Phase 1)
- Later: TNG eWallet / GrabPay (abstracted payment layer)

### PWA
- manifest.json
- service worker:
  - Cache static assets
  - Cache logged-in user data
  - Offline fallback UI

### Deployment
- Vercel (frontend + API)
- Supabase Cloud (database + auth + storage)

---

# 4. HIGH-LEVEL IMPLEMENTATION STEPS

### Step 1 – Project Setup
- Create Next.js app with Typescript
- Install Tailwind + shadcn/ui
- Install Supabase JS client
- Add PWA plugin (or manual SW)
- Configure environment variables for Supabase + Stripe

---

### Step 2 – Database Schema (Supabase)
Implement all tables described in section:
- users
- merchants
- merchant_locations
- services
- plans
- vehicles
- subscriptions
- subscription_vehicles
- bookings
- redemptions
- ratings_reviews
- analytics_events

Use RLS to enforce:
- Drivers only see their own vehicles/bookings
- Merchants only see their own branches/services
- Staff restricted by location_id
- Admin via service key

---

### Step 3 – Authentication & Role Handling
- On sign-up:
  - Save role to `users` table
- Middleware or layout checks redirect:
  - `/app/*` → drivers
  - `/merchant/*` → merchant owners + staff
  - `/admin/*` → admins

---

### Step 4 – User App (B2C)

1. Dashboard  
2. Explore merchants (map/list)  
3. Merchant detail  
4. Subscription listing + purchase  
5. Booking flow  
6. Check-in (QR/PIN)  
7. Wash history  
8. Profile/settings  

Each page should be responsive and PWA-first.

---

### Step 5 – Merchant SaaS Portal (B2B)

1. Dashboard  
2. Booking manager  
3. Redemption scanner  
4. Locations manager  
5. Services manager  
6. Staff manager  
7. Analytics dashboard  

Use shadcn DataTable, Cards, Tabs, Sheet, Dialog.

---

### Step 6 – Admin Portal

1. Merchant approvals  
2. Plan management  
3. Global analytics charts  
4. Dispute resolution  
5. System config pages  

---

### Step 7 – Payment Integration (Stripe)
- Create Stripe products from DB plans
- Webhooks:
  - subscription created
  - subscription renewed
  - subscription ended
- Update DB subscription state automatically

---

### Step 8 – PWA Finalisation
- Add icons in `/public`
- Add manifest.json
- Add service worker with:
  - Stale-while-revalidate caching
  - API fallback for offline
  - Guided install prompt

---

### Step 9 – Testing & QA
- Test for slow Malaysian internet (3G fallback)
- Ensure correct MYR formatting
- Check flows for:
  - Mobile wash
  - Unlimited plans
  - QR offline caching
  - Merchant check-in
  - Stripe renewals

---

# 5. RELEASE PLAN (PHASES)

### **Phase 1 – MVP**
- User app (basic)
- Subscription purchase
- Booking + QR check-in
- Merchant dashboard minimal
- Only fixed-location washes

### **Phase 2 – Operator SaaS**
- Full merchant analytics
- Staff accounts
- Peak-hour capacity tools

### **Phase 3 – Marketplace Expansion**
- Mobile wash (on-site)
- Family plans
- Ratings & reviews
- Referral & loyalty system

### **Phase 4 – Malaysia Optimisation**
- Bahasa support
- E-wallet payment integrations
- Push notifications
- Heatmaps & richer analytics

---

# 6. NOTES FOR CLAUDE/CODEX
- Follow Next.js App Router best practices
- Use server components for DB queries when possible
- Use TanStack Query for client-side reacting to changes
- Use shadcn/ui for all UI primitives to ensure consistent design
- Keep pages lean, offload heavy logic to API routes or server actions
- Prepare supabase types using `supabase generate types`


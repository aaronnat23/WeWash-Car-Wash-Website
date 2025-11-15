# claude.md – Car Wash Subscription SaaS (Malaysia-first, PWA)

## 0. High-Level Goal

Build a **car wash subscription + marketplace platform** for Malaysia:

- **B2C**: Drivers buy monthly/annual wash plans, discover nearby partner car washes, book slots, and track usage.
- **B2B**: Car wash operators manage subscriptions, bookings, and capacity via a SaaS dashboard.
- **Differentiator**: Modern, mobile-first PWA with **subscription-first**, **multi-location**, **analytics-driven** features + localisation for Malaysia (MYR, e-wallet flows later, Bahasa/English).

Tech stack:

- **Frontend / App**: Next.js (App Router) + TypeScript + TailwindCSS + shadcn/ui
- **Backend**: Next.js Route Handlers (API routes) + Supabase (Postgres + Auth + Storage)
- **Auth**: Supabase Auth (email/password, magic link, social later)
- **PWA**: Installable PWA with offline capabilities for key screens
- **Deployment**: Vercel (frontend + serverless API) + Supabase project

---

## 1. Product Overview

### 1.1 Core Concept

Create a platform similar to modern global car-wash subscription apps, adapted to Malaysia:

- **Subscription plans**:
  - Monthly/annual subscriptions (e.g. Basic, Standard, Premium) for wash services.
  - Support **unlimited** or **X washes/month** models.
  - Vehicle-type aware (sedan vs SUV/MPV).
  - Multi-car/family plans.

- **Marketplace**:
  - Users can see a **map/list of partner car washes**.
  - For each merchant: services, pricing, supported plans, ratings, opening hours.
  - Optional **mobile wash** (on-site at condo/office) as a flag.

- **Bookings & Check-ins**:
  - Users can book a time slot (for fixed locations) OR request on-demand wash.
  - At the wash location: QR code or PIN-based check-in to redeem a wash.

- **Operator SaaS**:
  - Car wash owners log into a **business dashboard**:
    - Manage locations, services, pricing.
    - See active subscriptions and redemptions.
    - Capacity planning and simple analytics.

- **Admin Portal**:
  - Internal admin to manage merchants, resolve issues, handle disputes/fraud, and see high-level metrics.

---

## 2. Feature Gaps to Exploit (vs existing players)

### 2.1 From global models

Global car-wash subscription players often provide:

- Unlimited or high-frequency wash plans.
- Strong app UX for registering vehicles and scanning QR at the wash.
- Focus on **recurring revenue + loyalty**.

**Gaps to exploit for Malaysia:**

- **Full PWA experience** (installable, offline) vs many native-only apps.
- Better **usage visibility**:
  - Show money saved vs pay-per-wash.
  - Show wash frequency, favourite locations, etc.

### 2.2 From local Malaysian models

Local offerings (membership clubs, aggregators, etc.) tend to:

- Sell **annual membership packs** via simple apps or websites.
- Offer multi-merchant access and discount plans.
- Limited SaaS tooling for the operators (capacity management, analytics).

**Gaps for us:**

- **All-in-one SaaS + consumer app**:
  - Fully featured operator dashboard (bookings, redemptions, staff roles).
  - Robust B2C app with **real booking flows** (time slots, QR check-in), not just generic membership.

- **True PWA**:
  - Many local merchants don’t want to install complex POS. A browser-based PWA for staff works great on Android tablets/phones.

- **Analytics & insights**:
  - Show operators: peak hours, subscription usage, plan profitability.
  - Show users: their car “care history” and savings.

- **Localized payments**:
  - Initially Stripe (or generic card) for coding simplicity.
  - Later integrate MY-specific payment gateways / e-wallets (e.g. TnG, GrabPay).

---

## 3. User Types & Roles

1. **Driver / Customer**
   - Sign up, verify email.
   - Add vehicles.
   - Browse merchants on map/list.
   - Purchase subscription plans.
   - Book wash slots / request on-demand wash.
   - Check-in at merchant (QR/PIN).
   - View wash history & savings.

2. **Merchant Owner**
   - Create and manage one or more wash locations.
   - Define services, pricing, supported plans.
   - Manage staff accounts.
   - Approve/deny bookings.
   - Redeem customer visits.
   - See analytics (wash count, revenue, subscriptions).

3. **Merchant Staff**
   - Restricted access: mainly check-in customers (QR/PIN), see upcoming bookings, mark jobs as completed.

4. **Platform Admin**
   - Manage merchants and users.
   - Approve merchant onboarding.
   - Force-cancel subscriptions or bookings.
   - View platform-wide metrics.

---

## 4. Tech Stack & Libraries

- **Framework**: Next.js (latest, App Router)
- **Language**: TypeScript (strict mode)
- **UI**:
  - TailwindCSS for utility-first styling.
  - **shadcn/ui** components for modern UI (e.g. Dialog, Sheet, Tabs, DataTable, Command, Calendar, Form).
- **State & Data**:
  - React Query / TanStack Query (for server state, caching Supabase queries).
  - React Context or Zustand for simple client-side app state (e.g. selected vehicle, current location).
- **Backend / Database**:
  - Supabase Postgres for relational data.
  - Supabase Auth for user management and role-based logic.
  - Supabase Storage (optional) to store merchant images, car images, etc.
- **Auth / RBAC**:
  - Supabase Auth + RLS policies to separate:
    - drivers (end users),
    - merchant owners,
    - merchant staff,
    - platform admins.
- **Payments**:
  - Phase 1: Stripe subscription API (for easiest integration).
  - Phase 2: integrate local payment gateways (abstract payment provider in code).
- **PWA**:
  - Use Next.js PWA plugin or manual service worker setup.
  - Add manifest.json & icons for installability.

---

## 5. High-Level Architecture

### 5.1 Frontend – Next.js App Router structure

Suggested route structure:

- `/` – Landing page (marketing)
- `/app` – Auth-gated driver app shell
  - `/app/dashboard` – main user dashboard (active plan, next booking)
  - `/app/merchants` – browse list + map
  - `/app/merchants/[merchantId]` – merchant detail + services + booking
  - `/app/subscriptions` – browse & purchase plans
  - `/app/bookings` – list + detail
  - `/app/vehicles` – manage vehicles
  - `/app/profile` – settings, language, payment methods
- `/merchant` – merchant portal shell (subdomain support later)
  - `/merchant/dashboard`
  - `/merchant/locations`
  - `/merchant/bookings`
  - `/merchant/customers`
  - `/merchant/analytics`
  - `/merchant/settings`
- `/admin` – admin portal
  - `/admin/merchants`
  - `/admin/users`
  - `/admin/plans`
  - `/admin/reports`

### 5.2 Backend – API Routes / Server Actions

Use **Next.js Route Handlers** under `/api`:

Examples (names only, no code):

- `/api/auth/callback` – Supabase auth handling if needed.
- `/api/merchants` – CRUD for merchant data (merchant-only + admin).
- `/api/locations` – location/address operations.
- `/api/plans` – fetch available plans, admin CRUD.
- `/api/subscriptions` – create/cancel/list subscriptions (calls Stripe/local gateway).
- `/api/bookings` – create/update/cancel bookings.
- `/api/checkin` – verify QR/PIN, record wash redemption.
- `/api/analytics` – aggregated metrics for dashboards.

Use **server actions** for form submissions where possible to reduce boilerplate, but keep payment flows inside API routes.

---

## 6. Data Model (Supabase – High Level)

Do **not** write SQL here. Just describe tables/fields so Claude/Codex can generate schema.

### 6.1 Core Tables

1. **users**
   - id (uuid, from Supabase auth)
   - role (`driver`, `merchant_owner`, `merchant_staff`, `admin`)
   - name
   - email
   - phone
   - created_at, updated_at

2. **merchants**
   - id
   - owner_id (FK to users)
   - name
   - description
   - logo_url
   - contact_phone
   - default_currency (MYR)
   - is_approved (bool)
   - created_at, updated_at

3. **merchant_locations**
   - id
   - merchant_id
   - name (e.g., “Branch – Subang Jaya”)
   - address_line1, address_line2
   - city, state, postcode, country
   - latitude, longitude
   - opening_hours (JSON)
   - is_mobile_service (bool)
   - is_active (bool)

4. **services**
   - id
   - merchant_id
   - name (e.g., “Exterior Wash”, “Interior Cleaning”)
   - description
   - base_price
   - estimated_duration_minutes
   - vehicle_type_applicable (enum or array)
   - is_active (bool)

5. **plans** (platform-wide subscription plans)
   - id
   - name (Basic, Standard, Premium, Family, etc.)
   - description
   - billing_period (`monthly`, `yearly`)
   - price_myr
   - max_washes_per_cycle (nullable for unlimited)
   - max_vehicles (1 for single, >1 for family)
   - includes_mobile_service (bool)
   - is_public (bool)
   - stripe_price_id (nullable, for Phase 1 payments)

6. **plan_merchant_mappings**
   - id
   - plan_id
   - merchant_id
   - optional override (e.g. plan not valid at all merchants, or different revenue share)

7. **vehicles**
   - id
   - user_id
   - nickname (e.g., “Myvi – daily”)
   - plate_number
   - make
   - model
   - year
   - vehicle_type (sedan, hatchback, SUV, MPV, pickup)
   - color
   - created_at, updated_at

8. **subscriptions**
   - id
   - user_id
   - plan_id
   - billing_provider (`stripe`, `local_gateway`)
   - billing_subscription_id (from provider)
   - start_date
   - current_period_start
   - current_period_end
   - status (`active`, `canceled`, `past_due`, `expired`)
   - cancel_at_period_end (bool)
   - metadata (JSON for extra information)

9. **subscription_vehicles**
   - id
   - subscription_id
   - vehicle_id

10. **bookings**
    - id
    - user_id
    - subscription_id (nullable – allow one-off non-subsidised booking)
    - vehicle_id
    - merchant_id
    - location_id
    - service_id (or array if multiple services)
    - booking_type (`in_location`, `mobile`)
    - scheduled_start, scheduled_end
    - status (`pending`, `confirmed`, `in_progress`, `completed`, `cancelled`, `no_show`)
    - total_price_myr (for non-sub or add-ons)
    - notes

11. **redemptions**
    - id
    - booking_id (nullable if walk-in)
    - subscription_id
    - vehicle_id
    - merchant_id
    - location_id
    - redeemed_at
    - redeemed_by_staff_id
    - method (`qr`, `pin`, `manual_admin`)
    - is_valid (bool) (for fraud resolution)

12. **ratings_reviews**
    - id
    - user_id
    - merchant_id
    - booking_id
    - rating (1–5)
    - comment
    - created_at

13. **analytics_events** (optional for detailed tracking)
    - id
    - user_id (nullable)
    - event_type (e.g. `booking_created`, `subscription_purchased`)
    - payload (JSON)
    - created_at

---

## 7. Auth, Roles & Security

- Use **Supabase Auth** for user authentication.
- Use **RLS policies** to enforce:
  - Drivers only see their own data (vehicles, subscriptions, bookings).
  - Merchant owners see only their merchant and related bookings/subscriptions.
  - Merchant staff only see bookings and redemptions for their assigned locations.
  - Admin has elevated access (bypass RLS via service role in server-side API).

Implementation notes:

- Map Supabase user to `users` row with role on sign-up.
- Provide two sign-up flows:
  - **Driver sign-up** (default).
  - **Merchant onboarding** (creates merchant request, flagged `is_approved = false` until admin approval).
- Use middleware or layout logic to route `/app` vs `/merchant` vs `/admin` based on role.

---

## 8. PWA Requirements

Goals:

- App should be installable on Android/iOS browsers and desktop.
- Support **offline-first** for:
  - Viewing current plan info.
  - Viewing last bookings / history.
  - For merchant staff: being able to see today’s booking list cached (read-only) if temporarily offline.

Implementation guidelines:

- Add **web app manifest**:
  - name, short_name, icons for various sizes.
  - display = `standalone`.
  - theme_color and background_color.

- Add **service worker**:
  - Cache static assets (Next.js static files, fonts, icons).
  - Cache selected API responses (e.g. `/api/me`, `/api/bookings?today`, `/api/plan`).
  - Offline fallback screen when calling API fails.

- Ensure core screens are **responsive** and touch-friendly:
  - Use shadcn `Sheet`, `BottomSheet`, `Dialog` for mobile interactions.
  - Use large tap targets for check-in buttons and QR scanning.

---

## 9. UI / UX Design Notes

Use **shadcn/ui** components + Tailwind, aim for clean, modern, minimalistic UI.

Key screens (B2C):

1. **Landing page**
   - Hero with headline: “Unlimited car washes for busy drivers in Malaysia.”
   - Benefits tiles.
   - CTA: “Get started” → sign-up.
   - Explainer section: “How it works” (Choose plan → Add car → Book wash → Scan QR).

2. **User dashboard**
   - Card showing **active subscription**:
     - Plan type, renewal date.
     - Washes used vs remaining (or “unlimited”).
     - Savings estimate this period.
   - Quick actions:
     - “Book a wash”
     - “View nearby locations”
   - Recent activity list.

3. **Merchant list + map**
   - Map (using a maps provider) + list.
   - Filters:
     - Distance radius.
     - Services (exterior, interior, detailing).
     - Mobile service available.
     - Open now.
   - Each merchant card:
     - Name, rating, distance.
     - Badge for “participates in your plan” or “plan not accepted”.

4. **Merchant detail**
   - Photos, description, rating.
   - Services and add-ons list.
   - Next available time slots.
   - Buttons:
     - “Book now”
     - “Add to favourites”
   - Show which subscription plans are accepted.

5. **Booking flow**
   - Stepper:
     1. Choose vehicle.
     2. Choose service(s).
     3. Choose location/time.
     4. Confirm & pay (only for non-sub or add-ons).
   - Use shadcn `Stepper`/`Tabs` + `Form` components.

6. **Check-in screen**
   - Display dynamic QR code that encodes booking + user info (short-lived token).
   - Option to display numeric pin code.
   - Show booking status and location name.

Merchant portal key screens:

- **Merchant dashboard**
  - Today’s bookings, current check-ins.
  - Quick filter by location.
  - KPI cards: washes this week, subscription vs one-off ratio, revenue.

- **Bookings List**
  - DataTable (shadcn) with sorting/filtering.
  - Actions: mark as in progress, completed, no-show.

- **Check-in screen**
  - QR scanner component (camera permission).
  - Fallback manual booking ID/PIN entry.

- **Analytics**
  - Basic charts (wash count by day/time, plan usage).
  - Use simple chart lib or shadcn-compatible chart components.

---

## 10. Payments & Subscription Logic

Phase 1 (for implementation simplicity):

- Use **Stripe** subscriptions:
  - Plans table stores `stripe_price_id`.
  - When user buys a plan:
    - Create Stripe customer (if not exists).
    - Create subscription based on price ID.
    - Store mapping in `subscriptions` table.

- Use Stripe webhooks via route:
  - `/api/webhooks/stripe`
  - Handle events:
    - `customer.subscription.created`
    - `customer.subscription.updated`
    - `customer.subscription.deleted`
    - `invoice.payment_failed`
  - Update `subscriptions.status`, `current_period_start`, `current_period_end` accordingly.

Future extension:

- Build an abstract `PaymentProvider` interface so that local payment gateways can be added later.
- The rest of the app should rely on internal subscription status, not direct Stripe calls.

---

## 11. Booking & Check-In Logic

### 11.1 Booking creation

- Check that:
  - User has an **active subscription** for this plan (if booking under subscription).
  - Vehicle is attached to subscription (or warn if not).
  - Plan is accepted by selected merchant/location.
  - User hasn’t exceeded max washes in current cycle (if applicable).

- For non-subscription bookings, calculate total price based on service(s) and vehicle type.

- Save booking with `status = pending` then `confirmed` if merchant auto-accept is on. Otherwise, allow merchant manual acceptance via portal.

### 11.2 Wash redemption & anti-fraud

- Generate a **short-lived token** (e.g. signed JWT or ULID) associated with booking.
- QR contains this token, merchant ID, and location ID.
- When scanned:
  - Backend verifies token, ensures booking belongs to this merchant/location, and status is confirmed.
  - Check that:
    - Not already redeemed.
    - Within the scheduled time window (with grace period).
  - Create `redemptions` row and update booking status to `in_progress` → `completed`.

- Limit multiple redemptions:
  - One redemption per booking.
  - Optionally track number of washes per period per subscription.

---

## 12. Analytics & Reporting

### 12.1 Merchant analytics

- Metrics:
  - Number of washes per day/week/month.
  - Distribution by plan vs one-off.
  - Revenue estimation (subscription share vs one-off).
  - Peak time slots.
  - Top customers (by frequency).

- Implementation:
  - Use Supabase SQL views or materialized views for heavy queries.
  - Expose via `/api/analytics/merchant` endpoints.

### 12.2 Platform analytics (admin)

- Metrics:
  - Total active subscriptions.
  - Churn rate.
  - Monthly Recurring Revenue (MRR) (approximated from stripe).
  - Merchant performance ranking.

---

## 13. Localisation & Settings

- Initial languages: English; structure app for easy **i18n**.
- Later add Bahasa Malaysia translations.
- Currency: MYR only at first; store numeric values and format on frontend.
- Time zone: default to Asia/Kuala_Lumpur, but store UTC in DB.

---

## 14. Phase Breakdown (for Coding)

### Phase 1 – Core MVP

- Auth & basic roles (driver vs merchant owner vs admin).
- Core data models (users, merchants, locations, vehicles, plans, subscriptions, bookings).
- Stripe integration for subscription purchase.
- B2C:
  - User dashboard.
  - Vehicle management.
  - Plan listing + purchase flow.
  - Merchant list & detail (without complex filters).
  - Simple booking and check-in (QR or PIN).
- Merchant portal:
  - Basic dashboard.
  - View today’s bookings.
  - Mark completed/no-show.

### Phase 2 – Marketplace & SaaS Enhancements

- Advanced filters & map view.
- Vehicle type specific pricing.
- Family plans (multiple vehicles).
- Ratings & reviews.
- Merchant analytics (charts).
- Staff accounts for merchants.
- Mobile wash/on-site support.

### Phase 3 – Optimisation & Local Integrations

- Full PWA offline caching and improved install UX.
- Local payment gateway & e-wallet integrations.
- Referral & loyalty programs.
- In-app notifications & email notifications.
- Admin tools for merchant onboarding, dispute resolution.

---

## 15. Non-Functional Requirements

- **Performance**:
  - Use SSR/ISR where appropriate for landing and public pages.
  - Use client-side queries with caching for app pages.
- **Security**:
  - Strict RLS on Supabase.
  - Do not expose Stripe secrets or admin keys to client.
- **Scalability**:
  - Design tables & indexes for typical workloads (bookings/queries).
  - Keep heavy analytics in views or scheduled jobs.

---

Use this document as the blueprint to generate:

1. Supabase schema (SQL migrations).
2. Next.js App Router structure and layouts.
3. shadcn/ui component composition for key screens.
4. Route Handlers for API endpoints and webhooks.
5. PWA config (manifest, service worker).

Focus on **clean TypeScript**, modular structure, and DX so the project can grow into a full SaaS over time.

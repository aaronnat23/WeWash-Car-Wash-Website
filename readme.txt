================================================================================
                    WeWash - Car Wash Subscription SaaS
================================================================================

PROJECT OVERVIEW
----------------
WeWash is a comprehensive car wash subscription and service marketplace platform
designed specifically for the Malaysian market. The platform features a Progressive
Web App (PWA) that works seamlessly on mobile devices.

KEY FEATURES
------------
* B2C App for Drivers
  - Multiple subscription tiers (Basic, Standard, Premium)
  - Vehicle management (multiple cars per account)
  - Merchant discovery with map view
  - Booking system with QR code check-in
  - Usage tracking and savings calculator
  - Ratings and reviews

* B2B SaaS for Merchants
  - Comprehensive dashboard with analytics
  - Booking management system
  - Staff account management
  - QR code redemption system
  - Multi-location support
  - Mobile wash service integration

* Admin Portal
  - Merchant approval and management
  - Global analytics and reporting
  - Subscription plan management
  - Fraud monitoring

TECHNOLOGY STACK
----------------
Frontend:
- Next.js (App Router)
- TypeScript
- Tailwind CSS
- shadcn/ui components
- TanStack Query
- Mapbox/Google Maps

Backend:
- Next.js Route Handlers
- Supabase (Postgres, Auth, Storage)
- Row-level security (RLS)

Payments:
- Stripe (subscription billing)
- Future: TNG eWallet, GrabPay

PWA Features:
- Offline capability
- Installable on Android/iOS
- Service worker caching
- Mobile-optimized UI

Deployment:
- Vercel (frontend + API)
- Supabase Cloud (database + auth)

PROJECT STRUCTURE
-----------------
/aaron_claude.md    - Complete technical specification and implementation guide

GETTING STARTED
---------------
1. Clone the repository
2. Install dependencies: npm install
3. Configure environment variables (Supabase + Stripe)
4. Set up Supabase database schema
5. Run development server: npm run dev

TARGET MARKET
-------------
Malaysia-first approach with features specifically designed for:
- Malaysian car wash operators
- Mobile/on-site car wash services
- MYR currency formatting
- Future Bahasa Malaysia support
- Local payment integrations

UNIQUE VALUE PROPOSITION
------------------------
- First full SaaS + consumer app combination in Malaysia
- Integrated mobile wash scheduling
- Real-time analytics for operators
- US-style unlimited wash subscriptions with modern UX
- PWA-first approach for better mobile experience

DEVELOPMENT PHASES
------------------
Phase 1: MVP (basic app, subscriptions, QR check-in)
Phase 2: Full operator SaaS (analytics, staff accounts)
Phase 3: Marketplace expansion (mobile wash, ratings)
Phase 4: Malaysia optimization (Bahasa, e-wallets, push notifications)

DOCUMENTATION
-------------
For detailed technical specifications, feature lists, and implementation
steps, please refer to aaron_claude.md in the project root.

================================================================================
                            WeWash © 2024
================================================================================

# 🚗 Car Rental Management App - UI Preview

## How to View the UI

### Option 1: View Locally (Recommended)
```bash
# Make sure you're on the Flutter branch
git checkout claude/create-oliver-markdown-01X8S2PRVxZtvRfKvde468Nj

# Install Flutter (if not installed)
# Visit: https://docs.flutter.dev/get-started/install

# Get dependencies
flutter pub get

# Run the app
flutter run -d chrome
```

### Option 2: After Deployment
Once merged to main, the app will be live at:
```
https://aaronnat23.github.io/WeWash-Car-Wash-Website/
```

---

## 📱 UI Screens Overview

### 1️⃣ DASHBOARD PAGE
```
┌─────────────────────────────────────┐
│  Dashboard                       ☰  │
├─────────────────────────────────────┤
│  Welcome back!                      │
│                                     │
│  ┌─────────┐  ┌─────────┐         │
│  │   🚗    │  │   🔑    │         │
│  │   24    │  │   12    │         │
│  │Total Cars│ │ Active  │         │
│  └─────────┘  └─────────┘         │
│                                     │
│  ┌─────────┐  ┌─────────┐         │
│  │   💰    │  │   ⏳    │         │
│  │ $4,250  │  │    3    │         │
│  │ Revenue │  │ Pending │         │
│  └─────────┘  └─────────┘         │
│                                     │
│  Recent Bookings                   │
│  ┌───────────────────────────────┐ │
│  │ 🚗 Tesla Model 3              │ │
│  │ Customer: John Doe            │ │
│  │ Nov 15, 2025                  │ │
│  │                    [Active] ✓ │ │
│  └───────────────────────────────┘ │
│  ┌───────────────────────────────┐ │
│  │ 🚗 BMW X5                     │ │
│  │ Customer: Jane Smith          │ │
│  │ Nov 16, 2025                  │ │
│  │                  [Upcoming] ⏰ │ │
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘
│ 📊 🚗 📅 👤 │  (Bottom Navigation)
```

**Color Scheme:**
- Primary: Blue (#2196F3)
- Cards: White with subtle shadow
- Active status: Green
- Upcoming status: Orange

---

### 2️⃣ CARS PAGE
```
┌─────────────────────────────────────┐
│  Available Cars              🔍 ⋮  │
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐ │
│  │ [   Car Image Placeholder   ] │ │
│  │         🚗                    │ │
│  │                               │ │
│  ├───────────────────────────────┤ │
│  │ Tesla Model 3    [Available]  │ │
│  │ 📁 Electric                   │ │
│  │                               │ │
│  │ $89/day      [📅 Book Now]    │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ [   Car Image Placeholder   ] │ │
│  │         🚗                    │ │
│  │                               │ │
│  ├───────────────────────────────┤ │
│  │ BMW X5          [Available]   │ │
│  │ 📁 SUV                        │ │
│  │                               │ │
│  │ $120/day     [📅 Book Now]    │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ Mercedes C-Class  [Rented] 🔴 │ │
│  │ 📁 Sedan                      │ │
│  │ $95/day      [Book Now] (×)   │ │
│  └───────────────────────────────┘ │
│                                     │
│              [➕ Add Car]           │  (FAB)
└─────────────────────────────────────┘
```

**Features:**
- Car cards with image placeholders
- Availability badges (green/red)
- Category icons
- Price per day in blue
- Disabled book button for rented cars
- Floating action button to add new cars

---

### 3️⃣ BOOKINGS PAGE
```
┌─────────────────────────────────────┐
│  Bookings                        ☰  │
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐ │
│  │ Tesla Model 3      [Active] ✓ │ │
│  │                               │ │
│  │ 👤 John Doe                   │ │
│  │ 📅 Nov 15 - Nov 18, 2025      │ │
│  │                               │ │
│  │ Total: $267.00  [View Details]│ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ BMW X5        [Upcoming] ⏰    │ │
│  │                               │ │
│  │ 👤 Jane Smith                 │ │
│  │ 📅 Nov 16 - Nov 20, 2025      │ │
│  │                               │ │
│  │ Total: $480.00  [View Details]│ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ Mercedes C-Class [Completed] □ │ │
│  │                               │ │
│  │ 👤 Bob Johnson                │ │
│  │ 📅 Nov 08 - Nov 13, 2025      │ │
│  │                               │ │
│  │ Total: $475.00  [View Details]│ │
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘
```

**Status Colors:**
- Active: Green background
- Upcoming: Orange background
- Completed: Gray background

---

### 4️⃣ PROFILE PAGE
```
┌─────────────────────────────────────┐
│  Profile                         ☰  │
├─────────────────────────────────────┤
│           ┌─────────┐               │
│           │   👤    │               │
│           │         │               │
│           └─────────┘               │
│                                     │
│          Admin User                 │
│      admin@carrental.com            │
│                                     │
├─────────────────────────────────────┤
│  ⚙️  Settings                    ›  │
├─────────────────────────────────────┤
│  🔔  Notifications               ›  │
├─────────────────────────────────────┤
│  💳  Payment Methods             ›  │
├─────────────────────────────────────┤
│  ❓  Help & Support              ›  │
├─────────────────────────────────────┤
│  ℹ️  About                       ›  │
├─────────────────────────────────────┤
│  🚪  Logout                         │  (Red)
└─────────────────────────────────────┘
```

**Features:**
- Large profile avatar
- User info display
- Clean list of settings options
- Chevron icons for navigation
- Red logout button at bottom

---

## 🎨 Design Highlights

### Typography
- **Font**: Poppins (Google Fonts)
- Clean, modern, and professional

### Color Palette
```
Primary:    #2196F3 (Blue)
Success:    #4CAF50 (Green)
Warning:    #FF9800 (Orange)
Error:      #F44336 (Red)
Background: #FFFFFF (White)
Surface:    #F5F5F5 (Light Gray)
Text:       #212121 (Dark Gray)
```

### Components Used
- ✅ Material Design 3
- ✅ Navigation Bar (Bottom)
- ✅ Cards with elevation
- ✅ Chips for status
- ✅ Floating Action Button
- ✅ List Tiles
- ✅ Filled Buttons
- ✅ Icons from Material Icons

### Responsive Design
- Works on mobile (320px+)
- Tablet optimized
- Desktop friendly
- PWA installable on all devices

---

## 🚀 Interactive Elements

1. **Dashboard Stats**: Click to view detailed analytics
2. **Car Cards**: Tap "Book Now" to create reservation
3. **Booking Items**: Tap "View Details" for full info
4. **Profile Options**: Navigate to respective settings
5. **FAB**: Quick add new cars to inventory

---

## 📊 Data Shown (Sample)

### Cars Inventory (6 vehicles)
- Tesla Model 3 ($89/day) - Electric - Available
- BMW X5 ($120/day) - SUV - Available
- Mercedes C-Class ($95/day) - Sedan - Rented
- Audi A4 ($85/day) - Sedan - Available
- Toyota Camry ($65/day) - Sedan - Available
- Honda CR-V ($75/day) - SUV - Rented

### Bookings (3 active)
1. Tesla Model 3 - John Doe - Active
2. BMW X5 - Jane Smith - Upcoming
3. Mercedes C-Class - Bob Johnson - Completed

---

## 🎯 Next Steps to See Live UI

1. **Merge this PR to main**
2. **GitHub Actions will automatically:**
   - Build the Flutter web app
   - Optimize for production
   - Deploy to GitHub Pages

3. **Access your live app at:**
   ```
   https://aaronnat23.github.io/WeWash-Car-Wash-Website/
   ```

4. **Install as PWA:**
   - Click install icon in browser
   - Add to home screen on mobile
   - Launch like a native app!

---

Built with ❤️ using Flutter & Material Design 3

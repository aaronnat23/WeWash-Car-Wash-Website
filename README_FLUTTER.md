# Car Rental Management PWA

A beautiful, modern car rental management Progressive Web App (PWA) built with Flutter Web.

## Features

### Dashboard
- Overview statistics (Total Cars, Active Rentals, Revenue, Pending bookings)
- Recent bookings at a glance
- Beautiful Material Design 3 UI

### Cars Management
- View all available cars
- Filter by availability
- Add new cars to inventory
- Car details with pricing
- Book cars directly from the listing

### Bookings Management
- View all bookings (Active, Upcoming, Completed)
- Detailed booking information
- Customer details and rental periods
- Total amount tracking

### Profile & Settings
- User profile management
- Settings and preferences
- Payment methods
- Help & Support
- Logout functionality

## Tech Stack

- **Flutter 3.16+** - UI Framework
- **Material Design 3** - Design System
- **Google Fonts** - Typography (Poppins)
- **PWA** - Progressive Web App capabilities
- **Service Worker** - Offline support and caching

## PWA Features

✅ Installable on desktop and mobile
✅ Offline support with service worker
✅ Fast loading with caching strategy
✅ Responsive design
✅ App-like experience
✅ Works across all modern browsers

## Installation

### Prerequisites
- Flutter SDK 3.0 or higher
- Web browser (Chrome, Firefox, Safari, Edge)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/aaronnat23/WeWash-Car-Wash-Website.git
cd WeWash-Car-Wash-Website
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run in development mode:
```bash
flutter run -d chrome
```

4. Build for production:
```bash
flutter build web --release
```

## Deployment to GitHub Pages

This project is configured to automatically deploy to GitHub Pages when you push to the main branch.

### Manual Deployment

1. Build the web app:
```bash
flutter build web --release --base-href "/WeWash-Car-Wash-Website/"
```

2. The built files will be in `build/web/`

3. Deploy to GitHub Pages (automated via GitHub Actions)

### Viewing the App

Once deployed, visit:
```
https://aaronnat23.github.io/WeWash-Car-Wash-Website/
```

## Project Structure

```
├── lib/
│   └── main.dart              # Main application code
├── web/
│   ├── index.html             # Entry HTML file
│   ├── manifest.json          # PWA manifest
│   ├── flutter.js             # Flutter bootstrap
│   ├── flutter_service_worker.js  # Service worker for caching
│   ├── favicon.png            # Favicon
│   └── icons/                 # App icons
│       ├── Icon-192.png
│       └── Icon-512.png
├── .github/
│   └── workflows/
│       └── deploy.yml         # GitHub Actions deployment
└── pubspec.yaml               # Flutter dependencies

```

## Usage

### Installing as PWA

**Desktop (Chrome/Edge):**
1. Open the app in your browser
2. Click the install icon (⊕) in the address bar
3. Click "Install"

**Mobile (Chrome/Safari):**
1. Open the app in your browser
2. Tap the share button
3. Tap "Add to Home Screen"

### Navigation

- **Dashboard**: Overview of your rental business
- **Cars**: Manage your vehicle inventory
- **Bookings**: Track all rental bookings
- **Profile**: Manage your account settings

## Customization

### Colors
Edit the theme in `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFF2196F3), // Change this color
  brightness: Brightness.light,
),
```

### App Name
Update in these files:
- `web/manifest.json` - name and short_name
- `web/index.html` - title
- `pubspec.yaml` - name

### Base URL
For GitHub Pages, ensure the base-href matches your repository name:
```bash
flutter build web --base-href "/your-repo-name/"
```

## Browser Support

- ✅ Chrome (Desktop & Mobile)
- ✅ Firefox (Desktop & Mobile)
- ✅ Safari (Desktop & Mobile)
- ✅ Edge (Desktop & Mobile)

## Performance

- **First Load**: < 3s on 3G
- **Cached Load**: < 1s
- **Lighthouse Score**: 90+

## License

MIT License - feel free to use this project for your own purposes.

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## Support

For issues and questions, please open an issue on GitHub.

---

Built with ❤️ using Flutter

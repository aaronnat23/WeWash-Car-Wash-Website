# Deployment Guide for Car Rental PWA

## GitHub Pages Deployment

This app is configured to automatically deploy to GitHub Pages using GitHub Actions.

### Prerequisites

1. Enable GitHub Pages in your repository:
   - Go to **Settings** → **Pages**
   - Under **Source**, select **GitHub Actions**

### Automatic Deployment

Every push to the `main` or `master` branch will trigger an automatic deployment:

1. GitHub Actions builds the Flutter web app
2. Optimizes and compiles for production
3. Deploys to GitHub Pages
4. Your app will be live at: `https://aaronnat23.github.io/WeWash-Car-Wash-Website/`

### Manual Deployment

If you need to manually deploy:

1. **Build the app locally:**
   ```bash
   flutter build web --release --base-href "/WeWash-Car-Wash-Website/"
   ```

2. **The built files will be in `build/web/`**

3. **Push to trigger deployment:**
   ```bash
   git add .
   git commit -m "Deploy updates"
   git push origin main
   ```

### Monitoring Deployment

1. Go to **Actions** tab in your GitHub repository
2. Click on the latest workflow run
3. Monitor the build and deploy steps
4. Once complete (green checkmark), your app is live!

### Troubleshooting

**Issue: 404 Not Found**
- Ensure GitHub Pages is enabled in repository settings
- Check that the base-href in the build command matches your repo name
- Wait a few minutes for GitHub Pages to propagate

**Issue: Workflow Failed**
- Check the Actions tab for error details
- Ensure all files are committed and pushed
- Verify `pubspec.yaml` has no syntax errors

**Issue: App doesn't load**
- Clear browser cache
- Check browser console for errors
- Verify all assets are loading correctly

### Custom Domain (Optional)

To use a custom domain:

1. Add a `CNAME` file to the `web/` directory with your domain
2. Configure DNS settings with your domain provider
3. Enable HTTPS in GitHub Pages settings

### Performance Tips

- Service Worker caches assets for offline use
- First visit may be slow; subsequent visits are instant
- PWA can be installed for app-like experience

### Security

- All traffic is served over HTTPS by GitHub Pages
- No sensitive data is stored in localStorage
- Service Worker only caches public assets

---

For more details, see [README_FLUTTER.md](./README_FLUTTER.md)

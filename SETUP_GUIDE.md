# PURSEONALITY — COMPLETE SETUP GUIDE

## STEP 1 — Replace your files

Copy each file from this zip to your Flutter project, matching the paths exactly:

```
lib/main.dart                           ← replace
lib/theme.dart                          ← replace
lib/models/product.dart                 ← replace
lib/providers/auth_provider.dart        ← replace
lib/providers/store_provider.dart       ← replace
lib/services/api_service.dart           ← replace
lib/services/notification_service.dart  ← replace (new)
lib/services/share_service.dart         ← replace (new)
lib/widgets/product_card.dart           ← replace
lib/screens/splash_screen.dart          ← replace
lib/screens/main_scaffold.dart          ← replace
lib/screens/home_screen.dart            ← replace
lib/screens/shop_screen.dart            ← replace
lib/screens/product_detail_screen.dart  ← replace
lib/screens/cart_screen.dart            ← replace (white screen FIXED)
lib/screens/checkout_screen.dart        ← replace (full 3-step checkout)
lib/screens/wishlist_screen.dart        ← replace
lib/screens/account_screen.dart         ← replace
lib/screens/login_screen.dart           ← replace
lib/screens/register_screen.dart        ← replace
lib/screens/order_history_screen.dart   ← replace
pubspec.yaml                            ← replace
AndroidManifest.xml → goes to android/app/src/main/AndroidManifest.xml
```

---

## STEP 2 — Install dependencies

Open a terminal in your Flutter project root and run:

```bash
flutter pub get
```

---

## STEP 3 — Android permissions

Replace `android/app/src/main/AndroidManifest.xml` with the `AndroidManifest.xml`
included in this zip. It adds the required permissions for:
- Internet access
- Push notifications (POST_NOTIFICATIONS)
- url_launcher (to open PayFast)

---

## STEP 4 — iOS permissions (if building for iPhone)

Add these to `ios/Runner/Info.plist` inside the `<dict>` tag:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

---

## STEP 5 — Hot restart

Do a full hot restart (not just hot reload):
- Press `Shift + R` in the terminal, or
- Stop the app and run `flutter run` again

---

## WHAT WAS FIXED

### Product cards too big
- Image height: 140px → **100px**
- `childAspectRatio`: changed to **0.72** in both shop_screen and home_screen
- Font sizes reduced to fit properly in 2-column mobile grid
- Cards use `Expanded` for the info section so they never overflow

### White cart screen
- The cart was rendering blank because it was missing its own content wrapper
- Now fully self-contained with empty state, item list, qty controls, and total bar
- Correctly reads from `store.cart` (which exists in your StoreProvider)

### Checkout missing
- Full 3-step checkout:
  - **Step 1**: Delivery details — courier (free) or Paxi (R85) with PEP point dropdown
  - **Step 2**: Order summary with promo code (try PURSE20 for 20% off), price breakdown
  - **Step 3**: Confirmation screen with order number
- After paying: clears cart + fires a push notification

### Push notifications
- `notification_service.dart` — fully wired in, called from `main.dart` and `checkout_screen.dart`
- No Firebase needed — works locally

### Native sharing
- `share_service.dart` — integrated into `product_detail_screen.dart` AppBar share button
- Opens the phone's native share sheet (WhatsApp, Instagram, SMS, email, etc.)

### Where login/registration data goes
Right now it goes to **SharedPreferences** (the phone's local storage only).
Any email + password (4+ chars) will work in demo mode.

To connect to a real backend when ready:
- Replace the `Future.delayed` blocks in `auth_provider.dart` with real `http.post` calls
- Your Next.js API at `https://purseonality.vercel.app/api` needs:
  - `POST /api/auth/login` → returns `{ user, token }`
  - `POST /api/auth/register` → returns `{ user, token }`
- Easiest option: use **Firebase Auth** (free, no backend code needed for auth)

---

## HOW TO ADD YOUR OWN PRODUCT PHOTOS

1. Create the folder `assets/images/` in your Flutter project root
2. Add your photos (JPG or PNG, recommended 400×400px)
3. In `pubspec.yaml`, uncomment these lines:
   ```yaml
   assets:
     - assets/images/
   ```
4. In `product.dart`, change each product's `imageUrl` from the Unsplash URL
   to `assets/images/yourfilename.jpg`
5. Run `flutter pub get` and hot restart

---

## PROMO CODES

Currently supported: `PURSE20` = 20% off

To add more, edit `ApiService.validatePromo()` in `api_service.dart`:
```dart
if (code == 'SAVE10') return {'success': true, 'discountPercent': 10};
if (code == 'PURSE20') return {'success': true, 'discountPercent': 20};
if (code == 'VIP30')   return {'success': true, 'discountPercent': 30};
```

---

## PAXI DELIVERY

- R85 flat rate, collected from any PEP store
- 20 major SA locations pre-loaded in the dropdown
- Customer gets SMS from Paxi when parcel is ready
- For the full Paxi API (real-time point lookup): https://developer.paxi.co.za

---

## PAYFAST PAYMENTS

Currently opens PayFast sandbox (test mode).
To go live:
1. Create a PayFast merchant account at https://payfast.io
2. In your Next.js backend, generate a real PayFast payment URL with your
   merchant ID and key
3. `ApiService.initiatePayment()` will return that URL and the app opens it

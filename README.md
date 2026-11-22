# CHILLA'S SPICORA
### THE ESSENCE OF INDIAN SPICES
**Location:** Guntur, Andhra Pradesh, India  
**Brand Positioning:** Premium Indian Spice and Flavour Company  
**Market:** India initially, with planned international expansion  

---

## 🌿 Brand Overview

CHILLA'S SPICORA is a premier national Indian spice company rooted in Guntur, Andhra Pradesh—the spice capital of Asia. Built with an elegant **Forest Green (`#174D35`)**, **Gold (`#D4A84F`)**, and **Cream (`#FFF8E9`)** palette, the platform merges heritage stone-milling traditions with modern ultrasonic cold-extracted liquid spice technology.

---

## 🚀 Key Features

### 1. Complete 48-Product Artisanal Catalogue
- **Category 1: Signature Liquid Flavours (6 Products)**
  - Traditional Chai Masala Liquid, Biryani Flavour Liquid, Ginger-Garlic Flavour Liquid, Cardamom Flavour Liquid, Tandoori Flavour Liquid, Pepper Flavour Liquid.
  - Planned pack sizes: 30 ml (~600 drops) and 50 ml (~1000 drops).
- **Category 2: Traditional Masala Powders (12 Products)**
  - Garam Masala, Chicken Masala, Mutton Masala, Biryani Masala, Sambar Powder, Rasam Powder, Red Chilli Powder (Guntur Sannam), Turmeric Powder, Coriander Powder, Cumin Powder, Chai Masala Powder, Kitchen King Masala.
  - Configurable pack sizes: 50 g, 100 g, 200 g, 500 g.
- **Category 3: Special Spice Blends (10 Products)**
  - Tandoori Masala, Fish Fry Masala, Prawn Fry Masala (Royyala Vepudu), Pepper Masala, Royal Biryani Spice Mix, Chicken Fry Masala (Kodi Vepudu), Andhra Special Masala, Curry Masala, Pulihora Spice Mix, Pulao Masala.
- **Category 4: Whole Spices (14 Products)**
  - Green Cardamom (8mm Bold Idukki), Black Cardamom, Cloves, Cinnamon (Ceylon Quills), Black Pepper (Tellicherry TGSEB), Cumin Seeds, Coriander Seeds, Fennel Seeds, Star Anise, Bay Leaves, Nutmeg, Mace (Javitri), Kashmiri Mongra Saffron, Dry Ginger (Sonth).
- **Category 5: Curated Combo Packs (6 Products)**
  - Kitchen Starter Kit, Biryani Special Kit, Chai Lovers Kit, Non-Veg Special Kit, Andhra Spice Collection, Premium Indian Spice Gift Box.

### 2. Food Safety & Legal Compliance Framework
- Explicit statutory statements highlighting proposed formulations undergoing laboratory validation.
- No fabricated FSSAI license numbers or false clinical claims.
- Product availability statuses: `Active` (Orderable Demo), `Development`, `Coming Soon`, `Out of Stock`, and `Discontinued`.

### 3. Shopping Cart & Razorpay Checkout Simulation
- Persistent cart in `localStorage` with drawer & full cart page.
- Free shipping meter (Free standard India shipping above ₹499).
- Active promo coupons: `SPICORA10` (10% off), `GUNTURFIRST` (15% off), `ROYAL20` (20% off).
- Checkout supporting Customer Details, Address, Pin Code, and simulated payment modes (Razorpay Sandbox, UPI QR, Cards, COD).
- Dynamic Confetti animation and printable invoice confirmation upon order completion.

### 4. Culinary Studio & Recipe Hub
- Master recipes for: Royal Kadak Chai, Hyderabadi Dum Chicken Biryani, Awadhi Mutton Biryani, Veg Biryani, Guntur Kodi Vepudu, Machilipatnam Fish Fry, Andhra Royyala Vepudu, Andhra Chicken Curry, and Rayalaseema Sambar.
- Clear prep times, step-by-step instructions, and one-click "Shop Paired Spice" links.

### 5. Institutional & Wholesale B2B Portal
- Tailored for Restaurants, Hotels, Caterers, Tea Franchises, and Distributors.
- Comprehensive enquiry form with volume estimation and product interest tracking.
- Leads instantly feed into the Admin Console for pipeline management.

### 6. Full Enterprise Admin Management Portal (`/admin`)
- Real-time sales analytics and order tracking.
- Product manager with full CRUD and instant status switching.
- Order fulfillment manager with live status updates (Placed → Processing → Shipped → Delivered).
- B2B lead status pipeline.
- Customer reviews moderation.
- One-click "Reset Demo Data" button.

---

## 🛠️ Technology Stack

- **Framework:** Next.js 14 (App Router, Server & Client Components)
- **Language:** TypeScript
- **Styling:** Tailwind CSS with custom royal gold & forest-green palette
- **Icons:** Lucide React
- **Animations:** Canvas Confetti & CSS Shimmers
- **Database Schema:** PostgreSQL / Supabase ready (`schema.sql` with 16 tables)
- **Deployment:** Vercel

---

## 📦 Getting Started

### 1. Install Dependencies
```bash
npm install
```

### 2. Run Local Development Server
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) in your browser.

### 3. Build for Production
```bash
npm run build
npm run start
```

---

## 🏛️ Database Deployment (PostgreSQL / Supabase)

A production-ready SQL script with 16 tables, constraints, foreign keys, and indexes is provided in `schema.sql`:
1. Log in to your [Supabase Dashboard](https://supabase.com).
2. Go to **SQL Editor**.
3. Paste the contents of `schema.sql` and click **Run**.

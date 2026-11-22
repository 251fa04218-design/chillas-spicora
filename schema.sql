-- =========================================================================
-- CHILLA'S SPICORA - E-COMMERCE DATABASE SCHEMA (PostgreSQL / Supabase)
-- "THE ESSENCE OF INDIAN SPICES"
-- Location: Guntur, Andhra Pradesh, India
-- =========================================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    full_name VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255),
    role VARCHAR(20) DEFAULT 'customer' CHECK (role IN ('customer', 'admin', 'wholesale_partner')),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. ADMIN USERS TABLE
CREATE TABLE IF NOT EXISTS admin_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) DEFAULT 'super_admin' CHECK (role IN ('super_admin', 'catalog_manager', 'order_fulfillment', 'support')),
    permissions JSONB DEFAULT '{"manage_products": true, "manage_orders": true, "manage_b2b": true}'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. CATEGORIES TABLE
CREATE TABLE IF NOT EXISTS categories (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    short_name VARCHAR(100) NOT NULL,
    slug VARCHAR(150) UNIQUE NOT NULL,
    description TEXT,
    hero_image TEXT,
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. PRODUCTS TABLE
CREATE TABLE IF NOT EXISTS products (
    id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) UNIQUE NOT NULL,
    tagline VARCHAR(255),
    category_id VARCHAR(50) REFERENCES categories(id) ON DELETE RESTRICT,
    packaging_type VARCHAR(20) CHECK (packaging_type IN ('liquid', 'powder', 'whole', 'combo')),
    short_description TEXT NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(30) DEFAULT 'Development' CHECK (status IN ('Active', 'Development', 'Coming Soon', 'Out of Stock', 'Discontinued')),
    origin VARCHAR(150) DEFAULT 'Guntur, Andhra Pradesh',
    flavour_notes TEXT[],
    storage_instructions TEXT,
    compliance_notice TEXT,
    commercial_approval_status VARCHAR(50) DEFAULT 'Proposed Concept',
    rating NUMERIC(3, 2) DEFAULT 5.0,
    review_count INT DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    is_new_arrival BOOLEAN DEFAULT FALSE,
    is_best_seller BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. VARIANTS TABLE (PACK SIZES & PRICES)
CREATE TABLE IF NOT EXISTS variants (
    id VARCHAR(100) PRIMARY KEY,
    product_id VARCHAR(100) REFERENCES products(id) ON DELETE CASCADE,
    size VARCHAR(100) NOT NULL, -- e.g. "30 ml", "50 ml", "100 g", "200 g", "500 g"
    price NUMERIC(10, 2) NOT NULL, -- Proposed demo price
    compare_at_price NUMERIC(10, 2),
    sku VARCHAR(100) UNIQUE NOT NULL,
    in_stock BOOLEAN DEFAULT TRUE,
    is_proposed BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. INGREDIENTS TABLE
CREATE TABLE IF NOT EXISTS ingredients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id VARCHAR(100) REFERENCES products(id) ON DELETE CASCADE,
    name VARCHAR(150) NOT NULL,
    percentage NUMERIC(5, 2),
    is_organic BOOLEAN DEFAULT FALSE,
    is_proposed BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 7. PRODUCT IMAGES TABLE
CREATE TABLE IF NOT EXISTS product_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id VARCHAR(100) REFERENCES products(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    alt_text VARCHAR(255),
    sort_order INT DEFAULT 0,
    is_primary BOOLEAN DEFAULT FALSE
);

-- 8. INVENTORY TABLE
CREATE TABLE IF NOT EXISTS inventory (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    variant_id VARCHAR(100) UNIQUE REFERENCES variants(id) ON DELETE CASCADE,
    quantity_available INT DEFAULT 100,
    low_stock_threshold INT DEFAULT 15,
    warehouse_location VARCHAR(100) DEFAULT 'Guntur Central Hub',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 9. ADDRESSES TABLE
CREATE TABLE IF NOT EXISTS addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_line1 TEXT NOT NULL,
    address_line2 TEXT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 10. COUPONS TABLE
CREATE TABLE IF NOT EXISTS coupons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(50) UNIQUE NOT NULL,
    discount_percent NUMERIC(5, 2) NOT NULL,
    max_discount NUMERIC(10, 2),
    min_order_value NUMERIC(10, 2) DEFAULT 0,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 11. CART TABLE
CREATE TABLE IF NOT EXISTS cart (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    session_id VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS cart_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cart_id UUID REFERENCES cart(id) ON DELETE CASCADE,
    variant_id VARCHAR(100) REFERENCES variants(id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 12. ORDERS TABLE
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    customer_info JSONB NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL,
    discount NUMERIC(10, 2) DEFAULT 0,
    coupon_code VARCHAR(50),
    shipping NUMERIC(10, 2) DEFAULT 0,
    total NUMERIC(10, 2) NOT NULL,
    payment_method VARCHAR(30) CHECK (payment_method IN ('razorpay', 'upi', 'card', 'netbanking', 'cod')),
    payment_status VARCHAR(30) DEFAULT 'Pending' CHECK (payment_status IN ('Pending', 'Paid', 'Test Mode Completed', 'COD Confirmed', 'Failed')),
    order_status VARCHAR(30) DEFAULT 'Placed' CHECK (order_status IN ('Placed', 'Processing', 'Shipped', 'Out for Delivery', 'Delivered', 'Cancelled')),
    tracking_number VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 13. ORDER ITEMS TABLE
CREATE TABLE IF NOT EXISTS order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id VARCHAR(100) REFERENCES products(id),
    variant_id VARCHAR(100) REFERENCES variants(id),
    product_name VARCHAR(200) NOT NULL,
    size VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    quantity INT NOT NULL,
    total NUMERIC(10, 2) NOT NULL
);

-- 14. PAYMENTS TABLE
CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    razorpay_order_id VARCHAR(100),
    razorpay_payment_id VARCHAR(100),
    razorpay_signature VARCHAR(255),
    amount NUMERIC(10, 2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'INR',
    status VARCHAR(30) NOT NULL,
    gateway_response JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 15. REVIEWS TABLE
CREATE TABLE IF NOT EXISTS reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id VARCHAR(100) REFERENCES products(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    author VARCHAR(150) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(200),
    comment TEXT NOT NULL,
    verified_purchase BOOLEAN DEFAULT FALSE,
    is_demo BOOLEAN DEFAULT TRUE,
    status VARCHAR(30) DEFAULT 'Approved' CHECK (status IN ('Approved', 'Pending', 'Flagged')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 16. B2B ENQUIRIES TABLE (WHOLESALE & BULK)
CREATE TABLE IF NOT EXISTS b2b_enquiries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_name VARCHAR(200) NOT NULL,
    contact_person VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    business_type VARCHAR(100) NOT NULL,
    gstin VARCHAR(50),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    estimated_volume VARCHAR(100) NOT NULL,
    product_interests TEXT[],
    notes TEXT,
    status VARCHAR(50) DEFAULT 'New' CHECK (status IN ('New', 'Under Review', 'Quotation Sent', 'Active Customer')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for lightning fast lookups
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_slug ON products(slug);
CREATE INDEX IF NOT EXISTS idx_products_status ON products(status);
CREATE INDEX IF NOT EXISTS idx_orders_customer_email ON orders((customer_info->>'email'));
CREATE INDEX IF NOT EXISTS idx_b2b_enquiries_status ON b2b_enquiries(status);

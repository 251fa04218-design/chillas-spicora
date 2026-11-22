import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        spicora: {
          green: {
            DEFAULT: "#174D35",
            50: "#f0f7f3",
            100: "#dbeef3",
            200: "#b5dfcd",
            300: "#84c6a6",
            400: "#4fa77c",
            500: "#27885b",
            600: "#174D35", // Primary Brand Green
            700: "#13422e",
            800: "#0f3424",
            900: "#0b251a",
            950: "#05130d",
          },
          gold: {
            DEFAULT: "#D4A84F",
            50: "#fbf8f0",
            100: "#f6eed9",
            200: "#eedbb3",
            300: "#e4c486",
            400: "#D4A84F", // Brand Gold
            500: "#c29135",
            600: "#a97626",
            700: "#87571f",
            800: "#6e451e",
            900: "#5b391c",
          },
          cream: {
            DEFAULT: "#FFF8E9",
            50: "#fffdf9",
            100: "#FFF8E9",
            200: "#fef0d2",
            300: "#fbe4b2",
          },
          spice: {
            chilli: "#C83E24",
            turmeric: "#E59E1B",
            saffron: "#DE7A22",
            cardamom: "#447847",
            clove: "#592E2B",
          }
        },
      },
      fontFamily: {
        serif: ["Playfair Display", "Georgia", "serif"],
        sans: ["Plus Jakarta Sans", "Inter", "system-ui", "sans-serif"],
      },
      boxShadow: {
        'premium': '0 10px 30px -5px rgba(23, 77, 53, 0.08), 0 4px 6px -2px rgba(23, 77, 53, 0.04)',
        'gold-glow': '0 0 25px rgba(212, 168, 79, 0.35)',
        'card-hover': '0 20px 35px -10px rgba(23, 77, 53, 0.15)',
      },
      backgroundImage: {
        'radial-gold': 'radial-gradient(circle at center, rgba(212, 168, 79, 0.15) 0%, transparent 70%)',
        'spice-pattern': 'radial-gradient(#d4a84f 0.75px, transparent 0.75px)',
      }
    },
  },
  plugins: [],
};
export default config;

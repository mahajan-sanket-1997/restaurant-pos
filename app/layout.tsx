import type { Metadata, Viewport } from 'next';
import './globals.css';
export const metadata: Metadata = { title: 'Restaurant POS | Table & Order Management', description: 'Multi-device restaurant point of sale and kitchen order management.', applicationName: 'Restaurant POS' };
export const viewport: Viewport = { themeColor: '#f7f8fa', width: 'device-width', initialScale: 1 };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="en"><body>{children}</body></html>; }

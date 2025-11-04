# Deployment Guide for Publixy

This guide will help you deploy the Publixy multi-tenant blog platform to Vercel.

## Prerequisites

Before deploying, ensure you have:

1. A [Vercel](https://vercel.com) account
2. A [Clerk](https://clerk.com) account for authentication
3. A PostgreSQL database (recommended providers below)
4. Your repository pushed to GitHub

## Database Setup

You'll need a PostgreSQL database. Here are recommended providers:

### Option 1: Vercel Postgres (Recommended)
1. Go to your Vercel dashboard
2. Navigate to Storage
3. Create a new Postgres database
4. Copy the `DATABASE_URL` connection string

### Option 2: Neon (Serverless Postgres)
1. Sign up at [neon.tech](https://neon.tech)
2. Create a new project
3. Copy the connection string

### Option 3: Supabase
1. Sign up at [supabase.com](https://supabase.com)
2. Create a new project
3. Get the connection string from Settings → Database

### Option 4: Railway
1. Sign up at [railway.app](https://railway.app)
2. Create a new PostgreSQL database
3. Copy the connection string

## Clerk Setup

1. Go to [clerk.com](https://clerk.com) and sign up/login
2. Create a new application
3. In the dashboard, navigate to "API Keys"
4. Copy:
   - `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`
   - `CLERK_SECRET_KEY`
5. Configure OAuth providers (optional):
   - Google, GitHub, etc.
6. Configure organization settings:
   - Enable organizations in Settings → Organization

## Deployment Steps

### Step 1: Import Project to Vercel

1. Go to [vercel.com/new](https://vercel.com/new)
2. Import your GitHub repository
3. Select the project

### Step 2: Configure Environment Variables

In the Vercel dashboard, add the following environment variables:

```
DATABASE_URL=postgresql://username:password@host:port/database
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_live_xxxxx
CLERK_SECRET_KEY=sk_live_xxxxx
NEXT_PUBLIC_CLERK_SIGN_IN_URL=/sign-in
NEXT_PUBLIC_CLERK_SIGN_UP_URL=/sign-up
NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL=/
NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL=/
NEXT_PUBLIC_ROOT_DOMAIN=yourdomain.com
```

**Important:** 
- Use your actual domain for `NEXT_PUBLIC_ROOT_DOMAIN` (e.g., `bloghub.com`)
- Make sure to use production keys from Clerk (starting with `pk_live_` and `sk_live_`)

### Step 3: Configure Build Settings

Vercel should auto-detect Next.js, but verify:
- **Framework Preset:** Next.js
- **Build Command:** `pnpm build` (or `npm run build`)
- **Output Directory:** `.next`
- **Install Command:** `pnpm install` (or `npm install`)

### Step 4: Deploy

1. Click "Deploy"
2. Wait for the build to complete (usually 2-3 minutes)

### Step 5: Set Up Database Schema

After first deployment:

1. Install Vercel CLI locally: `npm i -g vercel`
2. Link your project: `vercel link`
3. Pull environment variables: `vercel env pull .env.local`
4. Push database schema: `pnpm db:push`

Alternatively, you can:
- Use Drizzle Studio in production mode
- Run migration scripts from your local machine pointing to production DB

### Step 6: Configure Custom Domain & Subdomains

1. In Vercel dashboard → Settings → Domains
2. Add your custom domain (e.g., `yourdomain.com`)
3. Add wildcard subdomain: `*.yourdomain.com`
4. Configure DNS with your domain provider:
   ```
   Type: A
   Name: @
   Value: 76.76.21.21

   Type: CNAME
   Name: *
   Value: cname.vercel-dns.com
   ```

### Step 7: Update Clerk Configuration

1. Go to your Clerk dashboard
2. Navigate to "Paths" or "URLs"
3. Update authorized domains to include:
   - `yourdomain.com`
   - `*.yourdomain.com`

### Step 8: Test Your Deployment

1. Visit your main domain
2. Create an organization in Clerk
3. Create a blog post
4. Test subdomain access: `org-slug.yourdomain.com`

## Post-Deployment

### Monitoring

- Monitor application in Vercel dashboard
- Check logs for any errors
- Set up error tracking (e.g., Sentry)

### Database Backups

If using Vercel Postgres:
- Backups are automatic on paid plans
- For hobby plan, consider manual exports

For other providers, configure automatic backups.

### Updates

To deploy updates:
1. Push changes to your GitHub repository
2. Vercel will automatically deploy from the main branch

## Environment-Specific Settings

### Production
```env
NODE_ENV=production
NEXT_PUBLIC_ROOT_DOMAIN=yourdomain.com
```

### Staging (Optional)
Create a separate Vercel project for staging:
```env
NODE_ENV=staging
NEXT_PUBLIC_ROOT_DOMAIN=staging.yourdomain.com
```

## Troubleshooting

### Build Fails
- Check build logs in Vercel
- Verify all environment variables are set
- Ensure `package.json` has correct dependencies

### Subdomain Not Working
- Verify wildcard DNS is configured
- Check middleware.ts is processing subdomains
- Ensure `NEXT_PUBLIC_ROOT_DOMAIN` matches your domain

### Database Connection Issues
- Verify DATABASE_URL is correct
- Check database allows connections from Vercel IPs
- Ensure SSL is enabled if required

### Authentication Issues
- Verify Clerk keys are production keys
- Check domain is added to Clerk dashboard
- Ensure redirect URLs are correct

## Cost Estimation

### Free Tier
- Vercel: Free tier available (100GB bandwidth)
- Clerk: Free up to 5,000 MAU
- Neon: Free tier with 3GB storage

### Paid Plans
For production with higher traffic:
- Vercel Pro: $20/month
- Clerk Pro: Starts at $25/month
- Database: $10-50/month depending on usage

## Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Next.js Deployment](https://nextjs.org/docs/deployment)
- [Clerk Documentation](https://clerk.com/docs)
- [Drizzle ORM Documentation](https://orm.drizzle.team/docs/overview)

## Support

For issues specific to this application:
- Open an issue on GitHub
- Check existing documentation in README.md

For platform-specific issues:
- Vercel Support: [vercel.com/support](https://vercel.com/support)
- Clerk Support: [clerk.com/support](https://clerk.com/support)

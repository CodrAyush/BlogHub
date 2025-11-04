# Contributing to Publixy (BlogHub)

Thank you for your interest in contributing to Publixy! This document provides guidelines and instructions for contributing.

## Development Setup

### Prerequisites

- Node.js 18 or higher
- pnpm (recommended) or npm
- PostgreSQL database
- Clerk account for authentication

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/CodrAyush/BlogHub.git
   cd BlogHub
   ```

2. **Install dependencies**
   ```bash
   pnpm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env.local
   ```
   
   Fill in your actual values in `.env.local`

4. **Start PostgreSQL** (if using Docker)
   ```bash
   docker-compose up -d
   ```

5. **Push database schema**
   ```bash
   pnpm db:push
   ```

6. **Run the development server**
   ```bash
   pnpm dev
   ```

7. **Open your browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

## Project Structure

```
BlogHub/
├── app/                    # Next.js app directory
│   ├── (root)/            # Authenticated routes
│   ├── (subdomain)/       # Public subdomain routes
│   └── api/               # API routes
├── components/            # React components
│   └── ui/               # UI components
├── db/                   # Database schema and config
├── lib/                  # Utility functions
├── public/              # Static assets
└── scripts/             # Utility scripts
```

## Development Workflow

### Making Changes

1. Create a new branch
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes

3. Test your changes
   ```bash
   pnpm lint
   pnpm build
   ```

4. Commit your changes
   ```bash
   git add .
   git commit -m "Description of changes"
   ```

5. Push to your fork
   ```bash
   git push origin feature/your-feature-name
   ```

6. Create a Pull Request

### Code Style

- Follow the existing code style
- Run `pnpm lint` before committing
- Use TypeScript for type safety
- Write meaningful commit messages

### Testing Subdomains Locally

To test subdomain functionality locally:

1. Edit your `/etc/hosts` file (or `C:\Windows\System32\drivers\etc\hosts` on Windows):
   ```
   127.0.0.1 test-org.localhost
   127.0.0.1 another-org.localhost
   ```

2. Access subdomains at:
   - http://test-org.localhost:3000
   - http://another-org.localhost:3000

## Database Changes

When modifying the database schema:

1. Update `db/schema.ts`
2. Generate migration (optional):
   ```bash
   pnpm db:generate
   ```
3. Push changes to database:
   ```bash
   pnpm db:push
   ```
4. Test your changes thoroughly

## Available Scripts

- `pnpm dev` - Start development server
- `pnpm build` - Build for production
- `pnpm start` - Start production server
- `pnpm lint` - Run ESLint
- `pnpm db:push` - Push schema to database
- `pnpm db:studio` - Open Drizzle Studio
- `pnpm db:generate` - Generate migrations
- `pnpm deploy:check` - Check deployment readiness

## Deployment

Before deploying:

1. Run deployment check:
   ```bash
   pnpm deploy:check
   ```

2. Review [DEPLOYMENT.md](./DEPLOYMENT.md) for deployment instructions

## Submitting Issues

When submitting issues, please:

- Check if the issue already exists
- Provide a clear title and description
- Include steps to reproduce (for bugs)
- Include screenshots if applicable
- Specify your environment (OS, Node version, etc.)

## Pull Request Guidelines

- Keep PRs focused on a single feature/fix
- Update documentation if needed
- Ensure all tests pass
- Follow the existing code style
- Reference related issues in the PR description

## Questions?

If you have questions:

- Check the [README.md](./README.md)
- Review [DEPLOYMENT.md](./DEPLOYMENT.md)
- Open a discussion on GitHub
- Create an issue for bugs

## License

By contributing, you agree that your contributions will be licensed under the project's MIT License.

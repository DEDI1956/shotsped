#!/bin/bash

# VLES Trojan Worker - Deployment Script
# This script automates the deployment process for Cloudflare Workers

set -e

echo "🚀 VLES Trojan Worker - Starting Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE} $1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18+ and try again."
        exit 1
    fi
    
    NODE_VERSION=$(node --version | cut -d'v' -f2)
    print_status "Node.js version: $NODE_VERSION"
    
    # Check if npm is installed
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm and try again."
        exit 1
    fi
    
    # Check if wrangler is installed
    if ! command -v wrangler &> /dev/null; then
        print_warning "Wrangler CLI is not installed globally. Installing..."
        npm install -g wrangler
        print_status "Wrangler CLI installed successfully"
    fi
    
    print_status "All prerequisites are satisfied ✅"
}

# Install dependencies
install_dependencies() {
    print_header "Installing Dependencies"
    
    if [ -f "package.json" ]; then
        npm install
        print_status "Dependencies installed successfully ✅"
    else
        print_error "package.json not found. Make sure you're in the project root."
        exit 1
    fi
}

# Validate configuration
validate_config() {
    print_header "Validating Configuration"
    
    if [ ! -f "wrangler.toml" ]; then
        print_error "wrangler.toml not found. Please ensure configuration file exists."
        exit 1
    fi
    
    # Check if worker.js exists
    if [ ! -f "worker.js" ]; then
        print_error "worker.js not found. Please ensure the main worker file exists."
        exit 1
    fi
    
    print_status "Configuration validation passed ✅"
}

# Test the worker locally
test_local() {
    print_header "Testing Locally"
    
    read -p "Do you want to test the worker locally before deployment? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Starting local development server..."
        print_warning "Press Ctrl+C to stop the server when done testing"
        npm run dev
    else
        print_status "Skipping local testing"
    fi
}

# Deploy to Cloudflare
deploy_worker() {
    print_header "Deploying to Cloudflare"
    
    # Check if user is logged in to Cloudflare
    print_status "Checking Cloudflare authentication..."
    if ! wrangler whoami &> /dev/null; then
        print_error "Not logged in to Cloudflare. Please run 'wrangler login' first."
        exit 1
    fi
    
    # Deploy the worker
    print_status "Deploying VLES Trojan Worker..."
    wrangler deploy
    
    print_status "Deployment completed successfully! 🎉"
}

# Post-deployment setup
post_deployment() {
    print_header "Post-Deployment Setup"
    
    print_status "Your VLES Trojan Worker is now deployed!"
    print_status "Next steps:"
    echo "1. Access your worker at the provided URL"
    echo "2. Configure your domain (if applicable)"
    echo "3. Set up monitoring and alerts"
    echo "4. Configure custom routes"
    
    # Get worker URL
    WORKER_URL=$(wrangler route list 2>/dev/null | head -n1 | awk '{print $1}' || echo "Check Cloudflare dashboard")
    print_status "Worker URL: $WORKER_URL"
    
    # Show useful commands
    print_status "Useful commands:"
    echo "  - View logs: wrangler tail"
    echo "  - Check status: wrangler status"
    echo "  - Update environment: wrangler secret put"
    echo "  - View dashboard: https://dash.cloudflare.com"
}

# Main deployment function
main() {
    clear
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🚀 VLES TROJAN WORKER 🚀                ║"
    echo "║                  Advanced Proxy Solution                    ║"
    echo "║                AI-Powered Error Handling                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    check_prerequisites
    install_dependencies
    validate_config
    test_local
    deploy_worker
    post_deployment
    
    print_header "Deployment Complete!"
    print_status "Your VLES Trojan Worker is now live and ready to use! 🎊"
}

# Error handling
trap 'print_error "Deployment failed at line $LINENO. Exit code: $?"' ERR

# Run main function
main "$@"
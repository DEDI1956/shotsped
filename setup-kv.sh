#!/bin/bash

# Setup script for Cloudflare KV namespace
# Run this script before deploying the worker

echo "Setting up Cloudflare KV namespace..."

# Create production KV namespace
echo "Creating production KV namespace..."
wrangler kv:namespace create "ACCOUNTS_KV" --preview false || {
    echo "Error creating production KV namespace"
    exit 1
}

# Create preview KV namespace
echo "Creating preview KV namespace..."
wrangler kv:namespace create "ACCOUNTS_KV" --preview || {
    echo "Error creating preview KV namespace"
    exit 1
}

echo ""
echo "KV namespaces created successfully!"
echo ""
echo "IMPORTANT: Update wrangler.toml with the IDs returned above:"
echo ""
echo "[[kv_namespaces]]"
echo 'binding = "ACCOUNTS_KV"'
echo 'id = "<PRODUCTION_ID_HERE>"'
echo 'preview_id = "<PREVIEW_ID_HERE>"'
echo ""
echo "After updating wrangler.toml, run: ./deploy.sh"

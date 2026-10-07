#!/bin/bash

echo "=================================="
echo "Karate API Automation Framework"
echo "=================================="
echo ""

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "❌ Maven is not installed. Please install Maven first."
    exit 1
fi

echo "✅ Maven found"
echo ""

# Clean and install dependencies
echo "📦 Installing dependencies..."
mvn clean install -DskipTests

echo ""
echo "🚀 Running API tests..."
echo ""

# Run tests
mvn test

echo ""
echo "=================================="
echo "✅ Test execution completed!"
echo "=================================="
echo ""
echo "📊 View HTML Report:"
echo "   target/karate-reports/karate-summary.html"
echo ""

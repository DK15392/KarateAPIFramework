# Karate API Automation Framework

API automation for Practice Software Testing website using Karate Framework.

## Project Structure
```
KarateAPIFramework/
├── pom.xml
├── src/test/java/
│   ├── features/
│   │   └── products.feature
│   ├── runner/
│   │   └── TestRunner.java
│   └── karate-config.js
└── README.md
```

## Features

### Products API Testing
- ✅ Get all products sorted by price (low to high)
- ✅ Validate price sorting order
- ✅ Validate product structure and fields
- ✅ Assert all products have required data
- ✅ Validate lowest and highest priced products

## Prerequisites
- Java 11 or higher
- Maven 3.6+

## Installation

```bash
cd KarateAPIFramework
mvn clean install
```

## Run Tests

### Run all tests
```bash
mvn test
```

### Run specific feature
```bash
mvn test -Dkarate.options="classpath:features/products.feature"
```

### Run specific scenario
```bash
mvn test -Dkarate.options="--tags @smoke"
```

## Test Scenarios

### 1. Get Products Sorted by Price (Low to High)
- Endpoint: `GET /products?sort=price,asc`
- Validates:
  - Response status is 200
  - Products array is returned
  - Prices are sorted in ascending order
  - All products have required fields

### 2. Validate Product Structure
- Validates each product contains:
  - id (number)
  - name (string, not empty)
  - price (number, >= 0)
  - description (string)
  - category (object with id and name)
  - brand (object with id and name)
  - product_image (object)

### 3. Validate Price Range
- Extracts lowest and highest priced products
- Validates lowest price <= highest price
- Prints product details for verification

## Assertions Used

1. **Status Code**: `Then status 200`
2. **Schema Validation**: `And match response == { ... }`
3. **Array Validation**: `And match each response.data == { ... }`
4. **Conditional Assertions**: `And match each response.data contains { price: '#? _ >= 0' }`
5. **Custom JavaScript**: Price sorting validation using custom function
6. **Presence Check**: `And match response.data[0] contains { id: '#string' }`

## API Endpoint

**Base URL**: `https://api.practicesoftwaretesting.com`

**Endpoint**: `/products`

**Query Parameters**:
- `sort=price,asc` - Sort by price ascending (low to high)
- `sort=price,desc` - Sort by price descending (high to low)

## Reports

After test execution, reports are generated in:
- `target/karate-reports/` - HTML reports
- `target/surefire-reports/` - JUnit XML reports

## View HTML Report

```bash
open target/karate-reports/karate-summary.html
```

## Example Output

```
All Prices: [1.99, 5.49, 9.99, 12.99, 15.99, ...]
Prices are sorted from low to high: PASSED
All products have valid fields: PASSED
Total Products: 50
Lowest Price Product: Hammer - $1.99
Highest Price Product: Power Drill - $89.99
```

## Key Features

- ✅ RESTful API testing
- ✅ JSON schema validation
- ✅ Custom JavaScript functions
- ✅ Data-driven testing
- ✅ Comprehensive assertions
- ✅ Detailed HTML reports
- ✅ Easy to read Gherkin syntax

## Troubleshooting

If tests fail:
1. Check internet connection
2. Verify API endpoint is accessible: `curl https://api.practicesoftwaretesting.com/products`
3. Check Java version: `java -version`
4. Clean and rebuild: `mvn clean install`

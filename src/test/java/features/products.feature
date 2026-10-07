Feature: Practice Software Testing - Products API Automation
  Validate products sorted by price from low to high

  Background:
    * url 'https://api.practicesoftwaretesting.com'

  Scenario: Get all products sorted by price low to high and validate
    Given path '/products'
    And param sort = 'price,asc'
    When method GET
    Then status 200
    And match response.data == '#array'
    And match response.data[0] contains { id: '#string', name: '#string', price: '#number' }
    
    # Extract all prices
    * def prices = karate.jsonPath(response, "$.data[*].price")
    * print 'All Prices:', prices
    
    # Validate prices are sorted low to high
    * def isSorted = function(arr) { for(var i=0; i<arr.length-1; i++) { if(arr[i] > arr[i+1]) return false; } return true; }
    * assert isSorted(prices) == true
    * print 'Prices are sorted from low to high: PASSED'
    
    # Validate each product has required fields
    * def validateProduct = function(product) { return product.id && product.name && product.price >= 0 && product.category_id }
    * def allValid = karate.jsonPath(response, "$.data[*]").every(validateProduct)
    * assert allValid == true
    * print 'All products have valid fields: PASSED'

  Scenario: Validate individual product details with assertions
    Given path '/products'
    And param sort = 'price,asc'
    When method GET
    Then status 200
    
    # Validate response structure
    And match response == 
    """
    {
      current_page: '#number',
      data: '#array',
      first_page_url: '#string',
      from: '#number',
      last_page: '#number',
      last_page_url: '#string',
      links: '#array',
      next_page_url: '##string',
      path: '#string',
      per_page: '#number',
      prev_page_url: '##string',
      to: '#number',
      total: '#number'
    }
    """
    
    # Validate each product structure
    And match each response.data ==
    """
    {
      id: '#number',
      name: '#string',
      description: '#string',
      price: '#number',
      is_location_offer: '#boolean',
      is_rental: '#boolean',
      product_image_id: '#number',
      product_image: '#present',
      category_id: '#number',
      category: '#present',
      brand_id: '#number',
      brand: '#present'
    }
    """
    
    # Validate price is positive
    And match each response.data contains { price: '#? _ >= 0' }
    
    # Validate name is not empty
    And match each response.data contains { name: '#? _.length > 0' }
    
    # Count total products
    * def totalProducts = response.data.length
    * print 'Total Products:', totalProducts
    * assert totalProducts > 0

  Scenario: Validate lowest and highest priced products
    Given path '/products'
    And param sort = 'price,asc'
    When method GET
    Then status 200
    
    * def products = response.data
    * def lowestPrice = products[0].price
    * def highestPrice = products[products.length - 1].price
    
    * print 'Lowest Price Product:', products[0].name, '- $' + lowestPrice
    * print 'Highest Price Product:', products[products.length - 1].name, '- $' + highestPrice
    
    # Assert lowest price is less than or equal to highest
    * assert lowestPrice <= highestPrice
    
    # Validate lowest priced product
    And match products[0] contains
    """
    {
      id: '#number',
      name: '#string',
      price: '#number',
      category: { id: '#number', name: '#string' },
      brand: { id: '#number', name: '#string' }
    }
    """

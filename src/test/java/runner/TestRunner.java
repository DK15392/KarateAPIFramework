package runner;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
    
    @Karate.Test
    Karate testProducts() {
        return Karate.run("classpath:features/products.feature");
    }
}

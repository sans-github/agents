# JUnit 5 Reference

## Project Setup

- Place tests in `src/test/java` mirroring the main source package structure.
- Add the `org.junit.jupiter:junit-jupiter` aggregator -- it includes `junit-jupiter-api`, `junit-jupiter-engine`, and `junit-jupiter-params` transitively.
- Run tests with `mvn test`.

---

## Test Structure

### Naming

- Test class: `{ClassName}Test` (e.g., `OrderServiceTest` for `OrderService`).
- Test method: `methodName_should_expectedBehavior_when_scenario`.
- Use `@DisplayName` for human-readable descriptions in test reports.

### Pattern

Follow Arrange-Act-Assert (AAA):

```java
@Test
@DisplayName("should apply discount when order exceeds threshold")
void applyDiscount_should_reduceTotal_when_orderExceedsThreshold() {
    // Arrange
    Order order = new Order(150.00);

    // Act
    double total = pricingService.applyDiscount(order);

    // Assert
    assertThat(total).isEqualTo(135.00);
}
```

### Lifecycle hooks

| Annotation | Scope | Use for |
|---|---|---|
| `@BeforeEach` | Per test | Reset state, build fixtures |
| `@AfterEach` | Per test | Cleanup, close resources |
| `@BeforeAll` | Per class (static) | Expensive one-time setup (DB, container) |
| `@AfterAll` | Per class (static) | One-time teardown |

---

## Parameterized Tests

Prefer `@ParameterizedTest` by default. If a test covers more than one scenario or input variant, it must be parameterized. Use `@Test` only when there is genuinely a single case with no variants.

```java
@ParameterizedTest
@ValueSource(strings = {"", " ", "\t"})
void isBlank_should_returnTrue_when_inputIsBlank(String input) {
    assertThat(StringUtils.isBlank(input)).isTrue();
}
```

| Source | When to use |
|---|---|
| `@ValueSource` | Simple literals (strings, ints, booleans) |
| `@CsvSource` | Inline input/expected pairs |
| `@CsvFileSource` | CSV file from classpath (large datasets) |
| `@MethodSource` | Factory method returning `Stream<Arguments>` |
| `@EnumSource` | All or subset of enum constants |

---

## Assertions

Prefer AssertJ for fluency and readable failure messages:

```java
// AssertJ (preferred)
assertThat(result).isEqualTo(expected);
assertThat(list).hasSize(3).contains("item");

// JUnit built-in
assertEquals(expected, actual, "failure message");
assertAll(
    () -> assertEquals(1, result.getId()),
    () -> assertEquals("John", result.getName())
);

// Exceptions
assertThrows(IllegalArgumentException.class, () -> service.process(null));
assertDoesNotThrow(() -> service.process(validInput));
```

Use `assertAll` when checking multiple fields -- all failures surface in one run instead of stopping at the first.

---

## Mocking with Mockito

```java
@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock
    private OrderRepository repository;

    @InjectMocks
    private OrderService orderService;

    @Test
    void findById_should_returnOrder_when_exists() {
        given(repository.findById(1L)).willReturn(Optional.of(new Order(1L)));

        Order result = orderService.findById(1L);

        assertThat(result.getId()).isEqualTo(1L);
    }
}
```

- Mock at boundaries (repositories, HTTP clients, external services).
- Prefer interfaces to enable clean substitution.
- Use `given(...).willReturn(...)` (BDDMockito) for readability.

---

## Test Organization

```java
@Tag("fast")
class UserServiceTest {

    @Nested
    @DisplayName("create user")
    class CreateUser {

        @Test
        void should_persistUser_when_emailIsUnique() { ... }

        @Test
        void should_throwException_when_emailIsDuplicate() { ... }
    }
}
```

| Annotation | Purpose |
|---|---|
| `@Tag("fast")` / `@Tag("integration")` | Categorize for selective test runs |
| `@Nested` | Group related scenarios in an inner class |
| `@TestMethodOrder` + `@Order` | Control execution order (use sparingly) |
| `@Disabled("reason")` | Skip temporarily -- always include a reason |

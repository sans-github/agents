# Test Review Checklist

## Structure

- [ ] Tests follow Arrange-Act-Assert (AAA) pattern
- [ ] Each test covers exactly one behavior
- [ ] Tests are independent -- no shared mutable state, no ordering dependencies

## Naming

- [ ] Test class has `Test` suffix (e.g. `OrderServiceTest`)
- [ ] Test methods follow `methodName_should_expectedBehavior_when_scenario`
- [ ] `@DisplayName` used for human-readable output

## Parameterization

- [ ] All multi-scenario tests use `@ParameterizedTest`
- [ ] No duplicate test methods that differ only in input values
- [ ] Appropriate source annotation chosen (`@CsvSource`, `@MethodSource`, etc.)

## Assertions

- [ ] AssertJ used for fluency (`assertThat(...)`)
- [ ] `assertAll` used when checking multiple fields
- [ ] Exception cases use `assertThrows` or `assertDoesNotThrow`
- [ ] Assertion messages are descriptive on failure

## Mocking

- [ ] Only external dependencies are mocked (repositories, HTTP clients)
- [ ] No mocking of classes you own
- [ ] `@Mock` and `@InjectMocks` used via `@ExtendWith(MockitoExtension.class)`

## Organization

- [ ] Tests grouped by feature in packages
- [ ] Related scenarios clustered with `@Nested`
- [ ] `@Tag` applied (`"fast"` or `"integration"`)
- [ ] Any `@Disabled` test includes a reason

## Coverage

- [ ] Happy path tested
- [ ] Validation and error cases tested
- [ ] Boundary values tested (nulls, empty, min/max)

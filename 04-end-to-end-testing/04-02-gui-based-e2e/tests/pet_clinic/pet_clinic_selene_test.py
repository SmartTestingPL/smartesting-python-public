import pytest
from selene import be, browser, by


class TestPetClinicSelene:
    @pytest.fixture(autouse=True)
    def setup_teardown(self):
        browser.config.browser_name = "chrome"
        browser.config.base_url = "http://localhost:8080"
        browser.config.timeout = 2
        self.browser = browser
        yield
        self.browser.quit()

    def test_displays_error_message(self) -> None:
        self.browser.open("/")
        self.browser.element(by.link_text("OWNERS")).click()
        self.browser.element(by.link_text("ALL")).click()

        self.browser.element(by.partial_text("Jeff")).should(be.visible)

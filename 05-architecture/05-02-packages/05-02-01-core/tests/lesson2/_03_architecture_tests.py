import sys
from pathlib import Path

import pytest
from pylint import lint


class Test03Architecture:
    """Brak modyfikatorów dostępu nie pozwala na proste ograniczanie dostępu,
    ale zawsze możemy użyć statycznej analizy kodu w postaci linterów i wtyczek
    do nich aby wymusić pewne zależności pomiędzy naszymi modułami (a raczej ich brak).
    """

    @pytest.fixture(autouse=True)
    def setup(self):
        root_dir = Path(__file__).parents[2]
        self.paths_to_check = [
            str(root_dir / module_name)
            for module_name in ("smarttesting", "smarttesting_api", "tests")
        ]

    def test_run_pylint_checks_on_modules(self) -> None:
        """Uruchomienie pylinta programatycznie.

        Jest to odpowiednik uruchomienia go ręcznie w katalogu
        05-architecture/05-02-packages/05-02-01-core komendą
        `pylint smarttesting smarttesting_api/ tests/`.

        Zajrzyj koniecznie do pliku .pylintrc z konfiguracją i sprobuj zaimportować
        coś z smarttesting_api w module smarttesting.
        """
        lint.Run(self.paths_to_check, do_exit=False)

        sys.stdout.seek(0)
        output = sys.stdout.read()
        assert "Your code has been rated at 10.00/10" in output, output

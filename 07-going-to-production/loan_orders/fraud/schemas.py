import enum
from dataclasses import dataclass
from datetime import date
from uuid import UUID

import marshmallow
import marshmallow_dataclass
from marshmallow.fields import Field


class VerificationStatus(enum.Enum):
    VERIFICATION_PASSED = "VERIFICATION_PASSED"
    VERIFICATION_FAILED = "VERIFICATION_FAILED"


@dataclass(frozen=True)
class CustomerVerificationResult:
    """Rezultat weryfikacji klienta."""

    _user_id: UUID
    _status: VerificationStatus

    @property
    def user_id(self) -> UUID:
        return self._user_id

    @property
    def status(self) -> VerificationStatus:
        return self._status

    @property
    def passed(self) -> bool:
        return self._status == VerificationStatus.VERIFICATION_PASSED


class Gender(enum.Enum):
    MALE = enum.auto()
    FEMALE = enum.auto()


class Status(enum.Enum):
    STUDENT = enum.auto()
    NOT_STUDENT = enum.auto()


@dataclass
class Person:
    """Reprezentuje osobę do zweryfikowania."""

    _name: str
    _surname: str
    _date_of_birth: date
    _gender: Gender
    _national_id_number: str
    _status: Status = Status.NOT_STUDENT

    @property
    def name(self) -> str:
        return self._name

    @property
    def surname(self) -> str:
        return self._surname

    @property
    def date_of_birth(self) -> date:
        return self._date_of_birth

    @property
    def gender(self) -> Gender:
        return self._gender

    @property
    def national_id_number(self) -> str:
        return self._national_id_number

    @property
    def is_student(self) -> bool:
        return self._status == Status.STUDENT

    def student(self) -> None:
        self._status = Status.STUDENT

    @property
    def age(self):
        today = date.today()
        years_diff = today.year - self._date_of_birth.year
        had_birthday_this_year = (
            today.replace(year=self._date_of_birth.year) < self._date_of_birth
        )
        if had_birthday_this_year:
            years_diff -= 1

        return years_diff


@dataclass
class Customer:
    """Klient. Klasa opakowująca osobę do zweryfikowania."""

    _uuid: UUID
    _person: Person

    @property
    def uuid(self) -> UUID:
        return self._uuid

    @property
    def person(self) -> Person:
        return self._person

    @property
    def is_student(self) -> bool:
        return self._person.is_student

    @property
    def student(self):
        return self._person.student


class PrivateFieldsCapableSchema(marshmallow.Schema):
    def on_bind_field(self, field_name: str, field_obj: Field) -> None:
        # Dataclasses (w przeciwieństwie do attrs) nie aliasują prywatnych pól
        # w __init__, więc żeby API nie wymagało podawania pól w formacie "_uuid",
        # aliasujemy je usuwając podkreślnik
        field_obj.data_key = field_name.lstrip("_")


CustomerSchema = marshmallow_dataclass.class_schema(
    Customer, base_schema=PrivateFieldsCapableSchema
)

CustomerVerificationResultSchema = marshmallow_dataclass.class_schema(
    CustomerVerificationResult, base_schema=PrivateFieldsCapableSchema
)

from dataclasses import dataclass

from UnleashClient import UnleashClient

from fraud_verifier.feature_toggles.features import Feature


@dataclass
class FeatureManager:
    _unleash_client: UnleashClient

    def is_enabled(self, feature: Feature) -> bool:
        return self._unleash_client.is_enabled(feature.value)

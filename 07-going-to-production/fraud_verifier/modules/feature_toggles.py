from dataclasses import dataclass

import injector
from UnleashClient import UnleashClient
from fraud_verifier.feature_toggles.manager import FeatureManager


@dataclass(repr=False)
class FeatureTogglesModule(injector.Module):
    _token: str

    @injector.singleton
    @injector.provider
    def unleash_client(self) -> UnleashClient:
        client = UnleashClient(
            "http://unleash:4242/api/",
            "fraud-verifier",
            custom_headers={"Authorization": self._token},
            refresh_interval=0,
        )
        client.initialize_client()
        return client

    @injector.provider
    def manager(self, unleash_client: UnleashClient) -> FeatureManager:
        return FeatureManager(unleash_client)

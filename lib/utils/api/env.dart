enum Env { stg, prod }

const env = Env.prod;
const minVersion = '1.0.11';

String getBaseUrl() {
  return switch (env) {
    Env.stg => 'https://hustle-api.cranium.id',
    Env.prod => 'https://api.hustle.co.id',
  };
}

String getOneSignalAppID() {
  return switch (env) {
    Env.prod => '4d4afabe-7f15-4ccf-8d65-e168d707d0e7',
    Env.stg => '1096c197-49e6-4d44-a9b0-d1a7bf58b198',
  };
}

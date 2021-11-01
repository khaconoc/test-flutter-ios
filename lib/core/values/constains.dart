const kSize = 20;
const kTimeExpired = 3 * 60 * 1000;
// const kTimeExpired = 23 * 60 * 60 * 1000 + (59 * 60 * 1000 + 50 * 1000);
const kTimeRefresh = 5 * 60 * 1000;
// const kTimeRefresh = 23 * 60 * 60 * 1000 + (59 * 60 * 1000 + 40 * 1000);

const kToken = 'token';
const kRefreshToken = 'refreshToken';
const kAppLanguage = 'lang';
const kKeepLogin = 'keepLogin';
const kDevMode = 'devMode';
const kVersion = 'version';

const kClientId = 'huokgu&549^nb)(*3s23#4';
const kClientSecret = 'eb601de6-ydc4-34u2-g4ug-abd3c72h4019';
const kScope = 'profile email api1.read api1.write offline_access';

// envBuildReplace
Map appEnv = envDev;

Map env = {};

Map envDev = {
  ...env,
  'baseUrl': 'https://vnpost.ddns.net/kt1',
  'baseUrlNew': 'https://vnpost.ddns.net/mobile',
  'baseUrlSSO': 'https://vnpost.ddns.net/sso',
};

Map envPoc = {
  ...env,
  'baseUrl': 'https://vnpost.ddns.net/poc/kt1',
  'baseUrlNew': 'https://vnpost.ddns.net/poc/mobile',
  'baseUrlSSO': 'https://vnpost.ddns.net/poc/sso',
};

Map envKh = {
  ...env,
  'baseUrl': 'http://bckt1.cpt.gov.vn/mobile-api-gate-way/kt1',
  'baseUrlNew': 'http://bckt1.cpt.gov.vn/mobile-api-gate-way/mobile',
  'baseUrlSSO': 'http://bckt1.cpt.gov.vn/mobile-api-gate-way/sso',
};


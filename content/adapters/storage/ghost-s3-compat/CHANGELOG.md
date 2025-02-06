# ghost-s3-compat

## 2.1.0

### Changed
- Updated for ghost v0.10 compatability (#11 thanks to @acburdine)

## 2.0.0

### Changed
- Restored the ability to specify an `assetHost` in the Ghost `config.js` file.
- Added logging on image serving errors.

### Fixed
- Use path-style URLs to construct the S3 endpoint images can be read from to
avoid certificate validation failures.  This is necessary because common bucket
naming can include one or more dots `(.)`, such as images.yourdomain.com. If you
a virtual-hosted–style URL https://images.yourdomain.com.s3.amazonaws.com would
fail a certificate validity check because AWS uses a *.s3.amazonaws.com wildcard
cert. The certificate would be deemed invalid because RFC2818 allows matching of
only a single domain for a given wild card character.

## [1.0.2] - 2016-04-20
### Changed
- Add support for proxying local image requests to S3

## [1.0.1] - 2016-04-20
- Forked [spanishdict/ghost-s3-compat](https://github.com/spanishdict/ghost-s3-compat) from [muzik/ghost-s3](https://github.com/muzix/ghost-s3)

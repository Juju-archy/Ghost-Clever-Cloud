# Ghost S3 Storage, compatability mode

This module allows you to read and write images from Amazon S3 instead of
storing them locally.

After installing, new images that you save will use an absolute URL to S3. Any
requests to `/content/images/` will be proxied to S3, so that any previous
images in your blog will not be affected.

## Installation

You will need to have a the custom storage module directly in your project
directory, the easiest way to do this is:

```bash
$ npm install ghost-s3-compat
$ mkdir content/storage
$ cp -r node_modules/ghost-s3-compat content/storage/ghost-s3-compat
```

## Configuration

Create new IAM User with permissions to get object from that bucket. Save the
`ACCESS_KEY` and `ACCESS_SECRET_KEY`.

In `config.js`, add a `storage` block for each environment.

```javascript
    storage: {
        active: 'ghost-s3',
        'ghost-s3': {
            accessKeyId: 'Put_your_access_key_here',
            secretAccessKey: 'Put_your_secret_key_here',
            bucket: 'Put_your_bucket_name_here',
            region: 'Put_your_bucket_region_here'
        }
    },
```


### Asset host

You can add `assetHost` to your config to specify a virtual host url. This is
most frequently used with a content delivery network (CDN) such as CloudFront,
CloudFlare, or others. The modified `storage` block would be:

```javascript
    storage: {
        active: 'ghost-s3',
        'ghost-s3': {
            accessKeyId: 'ACCESS_KEY',
            secretAccessKey: 'SECRET_ACCESS_KEY',
            bucket: 'S3_BUCKET_NAME',
            region: 'S3_REGION',
            assetHost: 'https://cdn.yourdomain.com/'
        }
    }
```

You can add `assetHost` to your config to specify a virtual host url. For more
information, [read this section](http://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html)
in the AWS docs.

## Copyright & License

- Original work Copyright (c) 2015 Hoang Pham Huu <phamhuuhoang@gmail.com>
- Modified work Copyright (c) 2016 Curiosity Media, Inc.

Released under the [MIT license](https://github.com/spanishdict/ghost-s3-compat/blob/master/LICENSE).

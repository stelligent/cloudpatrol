cloudpatrol
===========

### Sensitive data

These files must be created manually and never committed to the repository (they are in .gitignore already).

##### 1. ```config/aws.yml```

Contains AWS credentials. Example:

```
common: &common
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
test:
  <<: *common
development:
  <<: *common
production:
  <<: *common
```

or, if you want to use different credentials for Rails environments:

```
test:
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
development:
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
production:
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
```

insomniaircd_webhook
====================

This is a simple GitHub webhook receiver to regenerate the InsomniaIRC network configs.

### Environment Variables

* `HOSTNAME` should be set to the IRCD hostname to generate the config for.
* `SECRET_KEY` should be set to the AES key to decrypt secrets in the config.
* `SECRET_TOKEN` should be set to the secret token in the GitHub webhook configuration.

Example command:

    HOSTNAME=hypocrisy.insomniairc.net \
    SECRET_KEY=SUPER_SECRET_KEY \
    SECRET_TOKEN=DIFFERENT_SECRET \
    ruby lib/insomniaircd_webhook.rb

# Emailer
#### An email templating tool with millisecond resolution for tracking duration on email opens.

Emailer works with a Node.JS app [Tracker](https://github.com/juliangiuca/tracker)
Ever wanted to know how long someone was reading your emailer for?

Emailer uses Gmail to send out unique emails to groups of people. Create a template,
specify customizations, and track!

At the moment, Emailer provides name customization (%name), and unique tracking per email.

The special sauce of Emailer is in a Node.JS server which streams a tracking pixel
embedded in the email back to the end user. This gives Emailer a millisecond resolution
of how long someone was reading your email for.

### Config
Ensure you set the location of the nodeJS app. This can be found in config/environments/<environment>.rb.
As part of the deployment process I grab all my secret files from BitBucket (database.yml, newrelic.yml). Clearly this won't work for you.

### FAQ
##### Gmail's proxy
Gmail doesn't like tracking pixels. Ordinarily Gmail will give a regular tracking service
a simple "Yes this has been opened" flag. With Emailer you can see multiple opens.

The millisecond resolution doesn't work with Gmail - we track the first 20ms of an open, but it's kinda a false positive

#### What if someone doesn't have images loading?
Then you get nothing! No tracking!

### License
MIT license

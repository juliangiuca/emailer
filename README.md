# Emailer
#### An email templating tool with millisecond resolution for tracking duration on email opens.

Emailer works with a Node.JS app [Tracker](https://github.com/juliangiuca/tracker).  

Ever wanted to know how long someone was reading your emailer for?  

Emailer uses Gmail to send out uniquely tracked emails to groups of people. Create a template,
specify customizations, and track!  

At the moment, Emailer provides name customization (%name), and unique tracking per email.  

The special sauce of Emailer is in a Node.JS server which streams a tracking pixel
to the end user's email. This gives Emailer a millisecond resolution
of how long someone was reading your email for.

### Config
Ensure you set the location of the nodeJS app. This can be found in config/environments/<environment>.rb.
As part of the deployment process I grab all my secret files from BitBucket (database.yml, newrelic.yml). Clearly this won't work for you.

### FAQ
##### Gmail's proxy
Gmail doesn't like tracking pixels. Ordinarily Gmail will give a regular tracking service
a simple "Yes this has been opened" flag. With Emailer you can see multiple opens.

The millisecond resolution doesn't work with Gmail - we track the first 20ms of an open, but it's kinda a false positive

#### Why did you build this?
I was spending a lot of time curating emails to be sent to a large engineering org, and wanted some metrics around how many people actually read the emails. Along the way, I started
fiddling with some of Node's controls, and instead of straight up serving the tracking pixel, I staggered it out for an interesting result.

#### What if someone doesn't have images loading?
Then you get nothing! No tracking!

### License
MIT license

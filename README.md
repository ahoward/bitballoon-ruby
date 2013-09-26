BitBalloon Ruby Client
======================

BitBalloon is a hosting service for the programmable web. It understands your documents, processes forms and lets you do deploys, manage forms submissions, inject javascript snippets into sites and do intelligent updates of HTML documents through it's API.

Installation
============

Install the gem by running

    gem install bitballoon

or put it in a Gemfile and run `bundle install`

    gem bitballoon


Authenticating
==============

You'll need an application client id and a client secret before you can access the BitBalloon API. Please contact us at team@bitballoon.com for your credentials.

Once you have your credentials you can instantiate a BitBalloon client.

   bitballoon = BitBalloon::Client.new(:client_id => "YOUR_API_KEY", :client_secret => "YOUR_API_SECRET")

Before you can make any requests to the API, you'll need to authenticate with OAuth2. The BitBalloon client supports two OAuth2 flows.

If you're authenticating on behalf of a user, you'll need to get a valid access token for that user. Use the BitBalloon client to request an authentication URL:

  url = bitballoon.authorize_url(:redirect_uri => "http://www.example.com/callback")

The user then visits that URL and will be prompted to authorize your application to access his BitBalloon sites. If she grants permission, she'll be redirected back to the `redirect_uri` provided in the `authorize_url` call. This URL must match the redirect url configured for your BitBalloon application. Once the user comes back to your app, you'll be able to access a `code` query parameter that gives you an authorization code. Use this to finish the OAuth2 flow:

  bitballoon.authorize!(token, :redirect_uri => "http://www.example.com/callback")


Sites
=====

Getting a list of all sites you have access to:

    bitballoon.sites.each do |site|
      puts site.url
    end

Getting a specific site by id:

    site = bitballoon.sites.get(id)

Creating a site from a directory:

    site = bitballoon.sites.create(:dir => "/tmp/my-site")

Creating a site from a zip file:

    site = bitballoon.sites.create(:zip => "/tmp/my-site.zip")

Both methods will create the site and upload the files. The site will then be processing.

    site.state == "processing"
    site.processing? == true

Refresh a site to update the state:

    site.refresh

Use `wait_until_ready` to wait until a site has finished processing.

    site = bitballoon.sites.create(:dir => "/tmp/my-site")
    site.wait_for_ready
    site.state == "ready"

Update the name of the site (its subdomain), the custom domain and the notification email for form submissions:

    site.update(:subdomain => "my-site", :custom_domain => "www.example.com", :notification_email => "me@example.com")

Deleting a site:

    site.destroy!

Forms
=====

Access all forms you have access to:

    bitballoon.forms

Access forms for a specific site:

    site = bitballoon.sites.get(id)
    site.forms
    
Access a specific form:

    form = bitballoon.forms.get(id)

Access a list of all form submissions you have access to:

    bitballoon.submissions

Access submissions from a specific site

    site = bitballoon.sites.get(id)
    site.submissions

Access submissions from a specific form

    form = bitballoon.forms.get(id)
    form.submissions

Get a specific submission

    bitballoon.submissions.get(id)

Files
=====

Access all files in a site:

    site = bitballoon.sites.get(id)
    site.files

Get a specific file:

    file = site.files.get(path) # Example paths: "/css/main.css", "/index.html"

Reading a file:

    file.read
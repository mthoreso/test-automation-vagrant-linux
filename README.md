# test-automation-vagrant-linux

This project provides the user with a development environment to run Cucumber tests.  
The build is **Ubuntu/Ruby/Cucumber/Selenium/PhantomJS**.  In about 10 minutes you can be up and running.

There are a number of Cucumber advanced configurations included to orient the new user with the
varying capabilities it provides.  

Lastly, there is a working `.feature` file with some passing tests.  However, two unfinished
`step_definitions` are left for the new user to complete to get them practicing web testing with Selenium.

## Dependencies

* [VirtualBox] (https://www.virtualbox.org/wiki/Downloads)
* [Vagrant] (https://www.vagrantup.com/downloads.html)
* Proxy Settings (if you are in a corporate environment)

## How to Get Started

   1) Install VirtualBox  
   2) Install Vagrant  
   3) Download the [test-automation] (https://github.com/mthoreso/test-automation/archive/master.zip) repository (above, click **Download ZIP**) and place it in:  `C:\Cucumber\test-automation`  
   4) In a command prompt move to the /test-automation directory (where your `Vagrantfile` lives) and run the following commands**:  

```
$ vagrant up
$ vagrant ssh
```

   5) Now you will be logged into your Ubuntu virtual machine.  Change into the **/vagrant** directory - this
   will be mirrored to your 'test-automation' directory in Windows, allowing you to run Cucumber tests.

```
[vagrant@test-automation /]$ cd /vagrant
[vagrant@test-automation vagrant]$ cucumber
```

Running the `cucumber` command above will run a short example test to show you it works.
You may now create your own feature files, step_definitions, and other Cucumber configuration files.

## **Corporate Proxy

If you are doing this at work and are behind a corporate proxy this all gets more complicated but,
don't worry, we can (probably?) handle that here.

You'll need to do three things before you perform step 4 above:

   4a) Create your `http_proxy` and `https_proxy` environment variables

**Linux**
```
$ export http_proxy=http://<username>:<password>@proxy.example.com:<port>
$ export https_proxy=_http://<username>:<password>@proxy.example.com:<port>
```
Side Note: if you have special characters in your password you may need to replace them with the [hex values] (http://www.asciitable.com/) instead:
Ex. `M@tt` becomes `M%40tt`

**Windows**  
It would be better for you to permanently set your 'http_proxy' and 'https_proxy' User environment variables.  You can do this by:  
1) Open **Control Panel**  
2) Select **System**  
3) Click **Advanced system settings** on the left menu (you need administrator priviledges)  
4) Go to the **Advanced** tab (at the top)  
5) Click the **Environment Variables** button (near the bottom)  
6) Look for **http_proxy** and **https_proxy** in the User section.  If they don't exist create them with just the proxy, not the user/password (Windows will use your login credentials for you):  
* http://proxy.example.com:<port>
* ex. http://webproxy.matt.com:80

   4b) Install the [Proxy Configuration Plugin for Vagrant] (https://github.com/tmatilai/vagrant-proxyconf).
```
$ vagrant plugin install vagrant-proxyconf
```

   4c) Create a master `Vagrantfile` in your `C:\Users\<username>\.vagrant.d` folder that looks like this:
```
Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://<username>:<password>@proxy.example.com:<port>"
    config.proxy.https    = "http://<username>:<password>@proxy.example.com:<port>"
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end
end
```

Handling it this way is an attempt to keep usernames and passwords outside of any Git repositories or shared `Vagrantfile`s

Then you should be good to join back up with step 4 above:
```
$ vagrant up
$ vagrant ssh
```

## Vagrant

Your Vagrant machine is now running locally and when you `vagrant ssh` you will be logging into this local machine.

You do NOT have to `vagrant destroy` the machine each time you are done with it.  You can simply `exit` out
of the SSH session and leave it running, or, if you'd like, you can `vagrant suspend` to put it to sleep.

```
[vagrant@test-automation vagrant]$ exit
$ vagrant suspend
 ...
$ vagrant up
$ vagrant ssh
[vagrant@test-automation /]$ cd /vagrant
```

When you `vagrant up` after suspending it, it will resume very quickly as it won't need to reload and install everything.
In fact, the only time it will need to re-install everything is when you create it the very first time, or destroy it.

## Cucumber

Cucumber can be configured using many files such as:

* `/features/support/env.rb`        - run pre- and post-configuration code.
* `/.env`                           - store usernames/passwords or other variables (make sure this file is listed in '.gitignore' file)
* `/cucumber.yml`                   - create Cucumber profiles that can easily be run from command line or from a build server
* `/features/support/*_helpers.rb`  - create helper methods that will be reused frequently - incorporate some Object Oriented Programming techniques

## Cucumber Practice

You'll probably notice at this point that Cucumber passed some tests but some are still `pending`.  Yeah, you
need to become oriented with this new web testing framework and practice your testing skills.

You'll want to read through the three completed step_definitions to figure out how we accomplish the
first few tasks spelled out in the `.feature` file.  You'll also want to find where the browser `DRIVER`
was created that keeps getting reused.  You might also want to find out how Cucumber is starting and
killing the PhantomJS service that you're utilizing as a headless browser!  And where'd the screenshots
come from that are located in `/screenshots`?

Here is a nice Ruby-Selenium [cheatsheet] (https://gist.github.com/huangzhichong/3284966) that could help you get started.

Don't forget to finish these step_definitions:
```
When(/^the user clicks the cucumber link$/) do
  pending # Write code here that will find and click the proper link
  # Hint, you've already found the correct link element above
  # and it has conveniently been assigned to an instance variable: '@link'
end

Then(/^that "([^"]*)" is displayed$/) do |webpage|
  pending # Write code here that verifies we are at the proper URL
  # Hint, it's easy to capture the current URL of a webpage.
  # Google 'ruby selenium get current url' to find out how!
end
```

## .gitignore

If you end up creating a git repository of your test automation files you'll want to ignore a bunch of files for
privacy reasons or to help keep your Vagrant build clean.  The beauty of this whole thing is that if you break or
corrupt your development environment you just destroy it and create it again.

## You Broke It, Now What?

```
$ vagrant destroy
$ vagrant up
$ vagrant ssh
```

Now you're back to your clean environment.  And it works.

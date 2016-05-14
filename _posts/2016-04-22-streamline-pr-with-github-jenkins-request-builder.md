---
layout: post
title: "Streamlining your GitHub code review process with GitHub Pull Request Builder"
author: gharcombe-minson
image: github-status.png
video: false
---

GitHub's existing PR (Pull Request) feature makes it easy to see what changed between branches,
but it doesn't always give you the full picture. If you have any kind of automated testing and 
currently use Jenkins, the following plugin can give you a full picture of the impact when you're ready to
merge a request.

The [GitHub Pull Request Builder](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin) plugin
is an easy way to plug your own Jenkins jobs into a pull request. High level features:

- Can run any job you can set up in Jenkins
- Simple whitelist permissions for running PR jobs
- Trigger phrases for running specific jobs
- Test results are published into PR status on GitHub
- Retry jobs with a phrase, in case of a setup issue with a job

#### Installation
There are no special instructions for installing the plugin - do as you normally would.

#### Configuring a sample job

![SCM](/content/images/github-pull-request-builder-sample-job1.png)
You will need to configure the *Source Code Management* section of your job specifically for the plugin. 
Note in the image above, the *Name*, *Refspec*, and *Branch Specifier* sections - these ensure the plugin can view changes in PR's
and the job runs against the correct commit hash. You will need to click the *Advanced* button to view some of the above fields.

![Build Triggers](/content/images/github-pull-request-builder-sample-job2.png)
You will need to select the *Advanced* and *Trigger Setup* buttons to view all of the fields shown above. Here's an explanation
of the available options:

- <a name="Admin-List"></a>Admin list: If you would like to approve running a job against a PR, then list here the github users that can approve running the job.
Our team is small enough that everyone is automatically approved (see the [Organization](#Organization) section).
- <a name="GitHub-Hook"></a>Use GitHub hooks: You may either set the job to poll for new PR's to run against (see the [Crontab](#Crontab) section),
or if you check this box, and have GitHub hooks set up, Jenkins will be told when a new PR has been created.
- <a name="Trigger-Phrase"></a>Trigger phrase: You can specify a trigger phrase (with regex) to run the job. This can be used to re-run
a job without making changes to the PR, in case of an environmental build failure for example.
- <a name="Only-Use-Trigger-Phrase"></a>Only use trigger phrase: Selecting this box will suppress running the job on a PR until the
trigger phrase is found in a PR description or comment.
- <a name="Close-Failed"></a>Close failed pull request automatically: I've never used this option, but my guess is the name is 
self-explanatory.
- <a name="Skip-Build-Phrase"></a>Skip build phrase: You can specify a phrase (with regex) that, if mentioned in the PR description,
will suppress running this job. <br/>**As of May 2016, this feature is broken, and can only be set in the global plugin settings**.
- <a name="Display-Build-Errors"></a>Display build errors on downstream builds: I could not find any documentation on this feature, and 
looking at the code indicates that nothing is using it, so use at your own peril.
- <a name="Crontab"></a>Crontab: If you are not using GitHub webhooks, then you will need to set a schedule of when the job should
look for PR's to run against. In the sample job image, we're checking every 2 minutes.
- <a name="Whitelist"></a>Whitelist: If you choose not to whitelist entire organizations (see the [Organization](#Organization) section), 
you have the option to whitelist teams or users. Those who are whitelisted will not require approval to run the job against their PR.

![Build Triggers Contd](/content/images/github-pull-request-builder-sample-job3.png)

- <a name="Organization"></a>Whitelist Organizations: Check this if you want everyone in the listed organizations
to be automatically approved, which will trigger the job when the PR is opened.
- <a name="Allow-Whitelist-Admins"></a>Allow whitelisted members of organizations as admins: Selecting this box will allow the above
whitelisted organizations to act as admins, without naming them individually in the [Admin List](#Admin-List).
- <a name="Build-Every-Pull-Request"></a>Build every pull request automatically without asking: Selecting this box will skip checking the PR
for trigger, skip or build phrases, or permissions, and just run the job every time. **Risky**.
- <a name="Build-Description"></a>Build description template: The default Jenkins job description will use the PR number and PR title.
If you would like to change it, you can here.
- <a name="Whitelist-Branches"></a>Whitelist target branches: By adding a branch (or branches) here, it will restrict the job to only
PR's merging into those branches.
- <a name="Trigger-Setup"></a>Trigger setup: At a minimum, I recommend changing the *Commit Status Context* to be specific to this job. 
If you have multiple job running on each PR, you will see this name displayed in the list of checks on the PR.

#### Impact on your PR
Once you have a few jobs configured to check your PR's, and you have run some of them, you will see something like this image
below on your PR:

![Build Triggers Contd](/content/images/github-pull-request-builder-sample-job4.png)

Now you have a better understanding of the impact of your PR, and can keep breaking updates out of your parent branches until you're ready!

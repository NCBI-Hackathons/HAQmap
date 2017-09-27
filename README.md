# The NCBI Style Hackathon Organizer Guide

This guide will contain information and tools to help organizers create their own NCBI-style hackathon.

![HAQmap flow diagram](HAQmap_flow_diagram.png)

## Tools in the kit
### HackathonBuilder
This Shiny app creates a push-button solution to creating a "hackathon starter kit."  Your kit will contain:
* a planning calendar containing tasks to be done in advance of your hackathon, based on your desired start date
* a form to accept applications from prospective participants
* a master planning spreadsheet for managing applicants, accepted participants, and teams
* a manuscript template for writing hackathon manuscripts
* and more, coming soon!

When this app is done, you'll be able to log in through Google and your kit will be created for you in a new Google Drive folder. 

### SlackBuilder
This Shiny app will automate the process of populating a Slack workspace with users and creating channels for each team.

It takes as input the URL for the Google Sheet containing your team list, in the original format from your HackathonBuilder kit (i.e. it will fail if you're changed the order of or removed any columns in your participant list) and the URL for your Slack workspace (you must create this manually).  It will then send email invitations to users, create channels for each team, and automatically invite users to the channel for their team.  


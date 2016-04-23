---
layout: post
title: "Making Docker on a Mac Easy"
author: gharcombe-minson
image: docker.png
video: false
---

So you develop on a Mac huh? Docker is a great tool, but it's only awesome out of the box on a Linux machine. 
[Docker Toolbox](https://www.docker.com/products/docker-toolbox "Docker Toolbox") does aid in setting up Docker, 
but to make it awesome you'll need a few more scripts to make it <i>feel</i> like your running Docker natively.

I chose to use [SaltStack](http://saltstack.com/) locally to manage my mac, but you don't have to. The samples 
provided are transferable to other languages and i'll cover the underlying problems being solved, so you can 
implement in your own way. 

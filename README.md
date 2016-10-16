# Vindinium::Client

## Introduction

This gem contains an easy-to-use client for the [Vindinium AI
Game](http://www.vindinium.org). It is not a starter package, i.e., it
contains no example bots. Instead, it is aimed at being the simplest possible
interface for any bot code.

## Usage

In your `Gemfile`:

  gem 'vindinium-client'

Then, in your own bot:

  require 'vindinium_client'
  client = Vindinium::Client.new(key)

  client.training(turns: 42, map: 'm1') do |map|
    # ...
  end

  client.arna do |map|
    # ...
  end

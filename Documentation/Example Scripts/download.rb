#!/usr/bin/env ruby

# Example ruby script for ThreadWatcher by Mr. Freeze, 2010
# gets the url from the browser, then asks for a save location and downloads and wathches the thread

require 'rubygems'
require 'appscript'
include Appscript

tWatcher = Appscript.app.by_id("com.freezeco.threadwatcher")

if tWatcher.is_running?
  if  tWatcher.documents.get.size > 0
    tWatcher.documents.first.newTab
  else
    tWatcher.make(:new => :document)
  end
else
  tWatcher.launch
  # make sure ThreadWatcher has finished launching before we continue
  sleep 1
end

tWatcher.documents.first.tabs.last.watchThreadFromBrowser(:saveSheet => true)
tWatcher.activate

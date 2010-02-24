#!/usr/bin/env /usr/bin/python

# Example python script for ThreadWatcher by Mr. Freeze, 2010
# gets the url from safari, then fetches the thread (does not automatically save it)

from appscript import *
import time

tWatcher = app(id='com.freezeco.threadwatcher')
if tWatcher.isrunning:
	if tWatcher.documents.count() > 0:
		tWatcher.documents.first.newTab()
	else:
		tWatcher.make(new=k.document)
else:
	tWatcher.launch()
	# wait till app finishes launching
	time.sleep(1)
	
# get the url of the front most safari window
safari = app('Safari')
theURL = safari.documents.first.URL.get()

# tell threadwatcher to fetch the thread in the last tab
# of the first window
tWatcher.documents.first.tabs.last.fetch(withURL=theURL)

import asyncio
import warnings
import pyppeteer
import sys

if not sys.warnoptions:
  warnings.simplefilter("ignore")

class page:
  def __init__(self, endpoint, title, script):
    self.endpoint = endpoint
    self.title = title
    self.script = script
    
    loop = asyncio.new_event_loop()
    loop.run_until_complete(self.execute())
    
  async def execute(self):
      browser = await pyppeteer.connect({'browserWSEndpoint': self.endpoint})
      pages = []
      for target in browser.targets():
          if target.type == 'page':
              page = await target.page()
              if page:
                  title = await page.title()
                  if title == self.title:
                    try:
                      self.source = await page.evaluate(self.script)
                    except:
                      self.source = sys.exc_info()[0]
      browser = await pyppeteer.disconnect(s)

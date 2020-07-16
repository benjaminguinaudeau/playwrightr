import warnings
warnings.simplefilter("ignore")
# warnings.filterwarnings(action='once')
import asyncio
import pyppeteer
import sys

  

class page:
  def __init__(self, endpoint, title, script):
    self.endpoint = endpoint
    self.title = title
    self.script = script
    
    try:
      loop = asyncio.new_event_loop()
      loop.run_until_complete(self.execute())
      loop.run_forever()
      tasks = Task.all_tasks()
      for t in [t for t in tasks if not (t.done() or t.cancelled())]:
        loop.run_until_complete(t)
    finally:
      loop.close()

    
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

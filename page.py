import warnings
warnings.simplefilter("ignore")
# warnings.filterwarnings(action='once')
import asyncio
import pyppeteer
import sys
import re

  

class page:
  def __init__(self, endpoint, title, script):
    self.endpoint = endpoint
    self.title = re.sub(r'\W+', '', title)
    self.script = script
    
    try:
      loop = asyncio.new_event_loop()
      loop.run_until_complete(self.execute())
    except:
      loop.stop()
      loop.close()
    finally:
      loop.stop()
      loop.close()

  async def execute(self):
      browser = await pyppeteer.connect({'browserWSEndpoint': self.endpoint})
      pages = []
      for target in browser.targets():
        if target.type == 'page':
            page = await target.page()
            if page:
                title = await page.title()
                if re.sub(r'\W+', '', title) == self.title:
                  try:
                    self.source = await page.evaluate(self.script)
                  except:
                    self.source = sys.exc_info()[0]
      await browser.disconnect()

# async def execute(endpoint, tab_id):
#   browser = await pyppeteer.connect({'browserWSEndpoint': endpoint})
#   pages = []
#   for target in browser.targets():
#     if target.type == 'page':
#         page = await target.page()
#         if page:
#             tab = await page._targetId()
#             print(tab)
# 
#                   if tab == tab_id:
#                     try:
#                       self.source = await page.evaluate(self.script)
#                     except:
#                       self.source = sys.exc_info()[0]
# loop = asyncio.new_event_loop()
# loop.run_until_complete(execute(e, tab_id))





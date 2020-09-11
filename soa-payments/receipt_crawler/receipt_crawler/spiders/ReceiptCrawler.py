import scrapy
from scrapy.loader import ItemLoader

from ..items import ReceiptCrawlerItem


class ReceiptCrawler(scrapy.Spider):
    name = 'receipt_crawler'

    def __init__(self, url, mail, **kwargs):
        super().__init__(**kwargs)
        self.url=url
        self.mail=mail

    def start_requests(self):
        yield scrapy.Request(url=self.url, callback=self.parse)

    def parse(self, response):
        print('parsing')

        item_loader = ItemLoader(item=ReceiptCrawlerItem(), response=response)
        item_loader.add_xpath('body','//html')
        item = item_loader.load_item()
        return {'content': item, 'mail': self.mail}
